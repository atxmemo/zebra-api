# Bowling REST API

This is a Ruby on Rails app that provides a REST API for Bowling games.

A game is considered complete once all frames have been scored, until then, a game is considered active.

[Here](http://bowling.about.com/od/rulesofthegame/a/bowlingscoring.htm) is some information on bowling scoring for reference.

## Install

    bundle install

## Run the app

    rails server

## Run the tests

    rails test test/

# Database Schema
```
  create_table "frames", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "status", default: 0
    t.integer "score"
    t.index ["game_id"], name: "index_frames_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "score"
  end

  create_table "shots", force: :cascade do |t|
    t.bigint "frame_id", null: false
    t.integer "knocked_pins"
    t.index ["frame_id"], name: "index_shots_on_frame_id"
  end
```    

# REST API

The REST API is described below.
NOTE: Below commands assume installation of the [httpie](https://httpie.org/) command line client.

Please see the [httpie installation](https://httpie.org/docs#installation) instructions for more information.

## Create a game

### Request

`POST /games`

    http post :3000/games

### Response

    HTTP/1.1 200 OK
    Cache-Control: max-age=0, private, must-revalidate
    Content-Type: application/json; charset=utf-8
    ETag: W/"93580d412bba799909391533d30cb672"
    Referrer-Policy: strict-origin-when-cross-origin
    Transfer-Encoding: chunked
    X-Content-Type-Options: nosniff
    X-Download-Options: noopen
    X-Frame-Options: SAMEORIGIN
    X-Permitted-Cross-Domain-Policies: none
    X-Request-Id: 86700351-76b2-4064-9ab5-6506accdaf9d
    X-Runtime: 0.140710
    X-XSS-Protection: 1; mode=block
    
    {
        "id": 2,
        "score": null,
        "status": "active"
    }

## Get a game

### Request

`GET /games/:id`

    http get :3000/games/1

### Response

    HTTP/1.1 200 OK
    Cache-Control: max-age=0, private, must-revalidate
    Content-Type: application/json; charset=utf-8
    ETag: W/"6678ac169232bbe5be2392c853781657"
    Referrer-Policy: strict-origin-when-cross-origin
    Transfer-Encoding: chunked
    X-Content-Type-Options: nosniff
    X-Download-Options: noopen
    X-Frame-Options: SAMEORIGIN
    X-Permitted-Cross-Domain-Policies: none
    X-Request-Id: 4870ae56-83d0-4a85-b74e-1ebf568d221b
    X-Runtime: 0.021074
    X-XSS-Protection: 1; mode=block
    
    {
        "frames": [
            {
                "game_id": 1,
                "id": 1,
                "score": null,
                "shots": [
                    {
                        "frame_id": 1,
                        "id": 1,
                        "knocked_pins": 10
                    }
                ],
                "status": "strike"
            },
            {
                "game_id": 1,
                "id": 2,
                "score": null,
                "shots": [
                    {
                        "frame_id": 2,
                        "id": 2,
                        "knocked_pins": 9
                    },
                    {
                        "frame_id": 2,
                        "id": 3,
                        "knocked_pins": 9
                    }
                ],
                "status": "available"
            }
        ],
        "id": 1,
        "score": 0,
        "status": "active"
    }

## Create a shot 

### Request

`POST /games/:id/shots`

`Valid knocked_pins params include 0-10`

    http post :3000/games/1/shots knocked_pins=10

### Response

    HTTP/1.1 200 OK
    Cache-Control: max-age=0, private, must-revalidate
    Content-Type: application/json; charset=utf-8
    ETag: W/"a430bc1a7280d933697076081561796e"
    Referrer-Policy: strict-origin-when-cross-origin
    Transfer-Encoding: chunked
    X-Content-Type-Options: nosniff
    X-Download-Options: noopen
    X-Frame-Options: SAMEORIGIN
    X-Permitted-Cross-Domain-Policies: none
    X-Request-Id: 47981cf5-b687-4e6d-b4d1-0b8e8eda2249
    X-Runtime: 0.028091
    X-XSS-Protection: 1; mode=block
    
    {
        "frame_id": 2,
        "id": 4,
        "knocked_pins": 10
    }


