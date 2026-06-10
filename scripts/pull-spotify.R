#!/usr/bin/env Rscript
# scripts/pull-spotify.R
#
# Downloads the TidyTuesday Spotify songs dataset and saves a tidy local copy
# for the Session 18 worked example.
#
# Why not pull from Spotify directly?
# In November 2024, Spotify deprecated the audio-features endpoint for any
# app created after Nov 27, 2024. New apps can't access valence, energy,
# danceability, etc. The TidyTuesday dataset is a public snapshot of about
# 33,000 tracks pulled in January 2020 — plenty of data, no API needed.
#
# Source:
#   https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-01-21
#
# To run, from the project root:
#   Rscript scripts/pull-spotify.R

library(tidyverse)
library(here)

# Download the raw data ------------------------------------------------------

url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv"
songs_raw <- read_csv(url)

# Tidy it up -----------------------------------------------------------------
# - Pull the release year out of the date column (some entries are year-only,
#   so we just grab the first 4 characters and turn it into a number).
# - Rename a few columns so they're easier to type in class.
# - Keep only the columns we'll actually use in the lecture.

songs <- songs_raw |>
  mutate(release_year = as.integer(substr(track_album_release_date, 1, 4))) |>
  rename(
    artist     = track_artist,
    album_name = track_album_name,
    popularity = track_popularity,
    genre      = playlist_genre,
    subgenre   = playlist_subgenre
  ) |>
  select(
    track_id, track_name, artist, album_name, release_year,
    popularity, genre, subgenre,
    danceability, energy, valence,
    acousticness, instrumentalness, liveness, speechiness,
    tempo, loudness, duration_ms
  )

# Quick sanity check ---------------------------------------------------------

cat("Total tracks:   ", nrow(songs), "\n")
cat("Unique artists: ", n_distinct(songs$artist), "\n")
cat("Year range:     ",
    min(songs$release_year, na.rm = TRUE), "-",
    max(songs$release_year, na.rm = TRUE), "\n\n")

cat("Tracks per genre:\n")
print(count(songs, genre))

cat("\nMean valence by genre:\n")
print(
  songs |>
    group_by(genre) |>
    summarise(mean_valence = round(mean(valence, na.rm = TRUE), 2))
)

# Save -----------------------------------------------------------------------

out_path <- here("files", "data", "spotify_songs.csv")
write_csv(songs, out_path)
cat("\nSaved ", nrow(songs), " tracks to:\n  ", out_path, "\n", sep = "")
