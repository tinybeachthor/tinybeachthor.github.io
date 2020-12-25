---
title: Universal REST client?
date: Oct 05, 2020
tags: [ universal, REST ]
description: Composable way to interact with web services.

---

# Universal REST client?

There has to be a better way to chain API calls then using custom
clients.

For when one wants to manipulate or just bulk-read data from an API.

## The foundations

Some observations regarding REST communication to keep in mind.

### All requests/responses are finite

There are 9 operations in total: GET, HEAD, POST, PUT, PATCH, DELETE, CONNECT, OPTIONS and TRACE.
Where GET, PUT, POST, PATCH and DELETE are the ones used for data manipulation.

The length of the request body is limited by the encapsulating protocol (usually HTTP).

### It's all JSON

The data is well structured, so matching and deconstructing is possible.

### Information in the structure

The structure of the data contains information about the relationships
of data.

E.g. chaining an array response to a request with single field value in the query,
we know automatically to map the request over the array.

## Concrete example

Let's say we want to:

__Like all songs in user's Spotify playlists.__

Or written in a more structured way:
```
Spotify.me.playlists.songs
Spotify.like
```

That little snippet completely describes the intent.
Now, just to execute it.

_All request/response data & samples taken from
[Spotify Web API Reference](https://developer.spotify.com/documentation/web-api/reference-beta/)
on 2020-10-02 and is subject to change._

### Get playlists

We start off with getting all user playlists.

Request:

```
GET https://api.spotify.com/v1/me/playlists
```

_(With a required `Authorization` header - will deal with this later.)_

Response body: (with fields omitted)

```json
{
  "href" : "https://api.spotify.com/v1/shows/38bS44xjbVVZ3No3ByF1dJ/episodes?offset=1&limit=2",
  "items" : [ {
    "href" : "https://api.spotify.com/v1/episodes/0Q86acNRm6V9GYx55SXKwf",
    "id" : "0Q86acNRm6V9GYx55SXKwf",
    "name" : "Okända katedralen i Dalsland",
    ...
  }, {
    "href" : "https://api.spotify.com/v1/episodes/1spUiev4ggXPq95a7KKHjW",
    "id" : "1spUiev4ggXPq95a7KKHjW",
    "name" : "Electrolux och folkhemmets Elon Musk",
    ...
  } ],
  "limit" : 2,
  "next" : "https://api.spotify.com/v1/shows/38bS44xjbVVZ3No3ByF1dJ/episodes?offset=3&limit=2",
  "offset" : 1,
  "previous" : "https://api.spotify.com/v1/shows/38bS44xjbVVZ3No3ByF1dJ/episodes?offset=0&limit=2",
  "total" : 499
}
```

And after depaginating:

```json
[
  {
    "href" : "https://api.spotify.com/v1/episodes/0Q86acNRm6V9GYx55SXKwf",
    "id" : "0Q86acNRm6V9GYx55SXKwf",
    "name" : "Okända katedralen i Dalsland",
    ...
  }, {
    "href" : "https://api.spotify.com/v1/episodes/1spUiev4ggXPq95a7KKHjW",
    "id" : "1spUiev4ggXPq95a7KKHjW",
    "name" : "Electrolux och folkhemmets Elon Musk",
    ...
  },
  ...
]
```

Just a HTTP request and response. Nothing new yet.

### Get playlists' songs

Next "map" this request over the previous response. (Without bothering
ourselves with too many details on how it would work in practice.)

```
GET https://api.spotify.com/v1/playlists/{playlist_id}/tracks
```

Also need to translate `id` into `{playlist_id}`

_(Again with a required `Authorization` header.)_

Response (after depaginating):

```json
[
  {
    "added_at": "2016-10-11T13:44:40Z",
    "added_by": { ... },
    "track": {
      "album": { ... },
      "artists": [ ... ],
      "href": "https://api.spotify.com/v1/tracks/7pk3EpFtmsOdj8iUhjmeCM",
      "id": "7pk3EpFtmsOdj8iUhjmeCM",
      "name": "Otra Vez (feat. J Balvin)",
      "uri": "spotify:track:7pk3EpFtmsOdj8iUhjmeCM",
      ...
    },
    ...
  },
  ...
]
```

This is a straightforward transformation, we get the `id` after a single
unwrapping of the array - executing a query for every playlist object.

### Save tracks for user

To "like" (or "save" in Spotify terminology) these tracks for the user,
we need to execute this request _(with `Authorization`, just like above)_.

```
PUT https://api.spotify.com/v1/me/tracks

{
  "ids": [
    "4iV5W9uYEdYUVa79Axb7Rh",
    "1301WleyT98MSxVHPZCA6M",
    ...
  ],
}
```

There is a maximum of 50 ids per request too.

We need to extract `track.id` from the array of tracks above, group them
by 50 and execute the `PUT` request above.

If all of these return `200 Success` we are done.

## Challenges

Looks like there is no easy-ish way to make this work.

### JSON is not enough

The JSON structure is not complete, and the missing domain-specific
details are too much to safely ignore.

For example matching something like

```json
{
  "track": {
    "id": 1,
  },
  "album": {
    "id": 1
  },
}
```

to a request requiring and `id` would need extra information to work.

## Conclusion

There is some initiative solving API usability:

1. [API composition layer](https://nordicapis.com/the-need-for-an-api-composition-layer/)
   defining how to compose API's in another layer on top of API's
   themselves.
2. [Real-World RESTful Service Composition: A Transformation-Annotation-Discovery Approach](https://ieeexplore.ieee.org/document/8241498)
   using all sorts of fancy stuff (wordnet) to create a conceptual model
   of the API, to facilitate human interaction.

Until a clear solution arises, `bash`, `jq` and `curl` is the way to
go.

