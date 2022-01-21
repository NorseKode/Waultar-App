# Content examples from data
Excerpts from the json files, on how different contents are structured

## Facebook

### overview

### events/your_event_responses.json
```json
{
    "events_joined": [
        {
            "name": "Fejring af de nye Danb\u00c3\u00a6rere fra 20/21",
            "start_timestamp": 1633705200,
            "end_timestamp": 1633762800
        },
        ...
    ]
    ...
    "events_declined": [
        // Same structure
        ...
    ]
    ...
    "events_interested": [
        // Same structure
        ...
    ]
    ...
}
...
```

### facebook_gaming/instant_games

```json
{
  "instant_games_played_v2": [
    {
      "name": "Quiz Planet",
      "added_timestamp": 1587572979,
      "user_app_scoped_id": 3534557563281569,
      "category": "inactive"
    },
    ...
  ]
}
```

### polls/polls_you_voted_on

```json
{
  "poll_votes_v2": [
    {
      "timestamp": 1514417414,
      "attachments": [
        {
          "data": [
            {
              "poll": {
                "options": [
                  {
                    "option": "Experty",
                    "voted": true
                  },
                  {
                    "option": "WePower",
                    "voted": true
                  },
                  {
                    "option": "Nucleus Vision",
                    "voted": true
                  },
                  {
                    "option": "Coinvest",
                    "voted": true
                  }
                ]
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har stemt i Jaafar Mahers meningsm\u00c3\u00a5ling."
    },
    ...
    {
      "timestamp": 1535295867,
      "attachments": [
        {
          "data": [
            {
              "poll": {
                "options": [
                  {
                    "option": "Kan ikke",
                    "voted": true
                  }
                ]
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har stemt i Joakim Grums meningsm\u00c3\u00a5ling."
    },
```

### comments_and_reactions\posts_and_comments.json

```json
{
    "reactions_v2": [
        {
        "timestamp": 1242917167,
        "data": [
            {
            "reaction": {
                "reaction": "LIKE",
                "actor": "Lukas Vinther Offenberg Larsen"
            }
            }
        ],
        "title": "Lukas Vinther Offenberg Larsen likes Henriette Offenberg's post."
        },
        ...
    ]
}
```

### search/your_search_history

```json
{
  "searches_v2": [
      {
      "timestamp": 1637855464,
      "attachments": [
        {
          "data": [
            {
              "text": "\"itu\""
            }
          ]
        }
      ],
      "data": [
        {
          "text": "itu"
        }
      ],
      "title": "Du har s\u00c3\u00b8gt p\u00c3\u00a5 Facebook"
    },
    ...
  ]
}
```

### your_interactions_on_facebook/recently_visited.json

```json
{
  "visited_things_v2": [
      {
        "name": "Profile visits",
        "description": "People whose profiles you've visited",
        "entries": [
            {
            "timestamp": 1633211228,
            "data": {
                "name": "Finn Larsen",
                "uri": "https://www.facebook.com/finn.steen.52"
            }
            },
            ...
        ]
      }
      ...
      {
      "name": "Page visits",
      "description": "Pages you've visited",
      "entries": [
        {
          "timestamp": 1633893488,
          "data": {
            "name": "Shinson Hapkido Holb\u00c3\u00a6k",
            "uri": "https://www.facebook.com/SHHolbaek/"
          }
        }
      ]
    },
    ...
    {
      "name": "Events visited",
      "description": "Event pages you've visited",
      "entries": [
        {
          "timestamp": 1636048430,
          "data": {
            "name": "Ninja Nyt\u00c3\u00a5r",
            "uri": "https://www.facebook.com/events/392759309240403/"
          }
        },
        ...
      ]
    },
    ...
    {
      "name": "Groups visited",
      "description": "Groups you've recently visited",
      "entries": [
        {
          "timestamp": 1636202525,
          "data": {
            "name": "En gruppe hvor vi alle lader som om vi er Boomers",
            "uri": "https://www.facebook.com/groups/boomergruppen/"
          }
        },
        ...
      ]
    },
    ...
    {
      "name": "Marketplace visits",
      "description": "Dates you've visited Marketplace",
      "entries": [
        {
          "data": {
            "value": "19 May 2021"
          }
        },
        ...
      ]
    },
    ...
  ]
}
```

### your_interactions_on_facebook/recently_viewed.json
```json
"recently_viewed": 
[
    {
      "name": "Videoer og serier p\u00c3\u00a5 Facebook Watch",
      "description": "Videoer og serier, du for nylig har bes\u00c3\u00b8gt eller set fra Facebook Watch, og den tid du har brugt p\u00c3\u00a5 at se serier",
      "children": [
        {
          "name": "Tidsforbrug",
          "description": "Den tid, du har brugt p\u00c3\u00a5 at se videoer fra en serieside",
          "entries": [
            {
              "timestamp": 1556805143,
              "data": {
                "name": "Hashem Al-Ghaili",
                "uri": "https://www.facebook.com/ScienceNaturePage/",
                "watch_time": "30"
              }
            },
        ...
          ],
        },
        {
          "name": "Visninger",
          "description": "En liste over individuelle videoer, du har set",
          "entries": [
            {
              "timestamp": 1598024095,
              "data": {
                "uri": "https://www.facebook.com/failarmy/videos/701268073748841/",
                "name": "FailArmys video: Boatload of Fails"
              }
            },
        ...
          ],
        },
        {
          "name": "Visningstid",
          "description": "Den del af en enkelt video, du har set",
          "entries": [  
            {
            "timestamp": 1601804273,
            "data": {
              "uri": "https://www.facebook.com/vivaladirtleague/videos/2610007802643472/",
              "name": "Viva La Dirt Leagues video: Karen vs Manager",
              "watch_position_seconds": "90.162"
            }
            },
            ...
          ],
        },
      ],
    },
    {
      "name": "Opslag, som er blevet vist til dig i dine nyheder",
      "description": "Opslag, der er blevet vist til dig i dine nyheder inden for de eneste 90 dage.",
      "entries": [
        {
          "timestamp": 1637185809,
          "data": {
            "name": "IT-Universitetet i K\u00c3\u00b8benhavns opslag ",
            "uri": "https://www.facebook.com/ITUniversitetet/posts/4606108016099737"
          }
        },
        ...
      ],
    },
    {
      "name": "Videoer, du har set",
      "description": "Videoer, du har set i de seneste 90 dage.", // only showing 90 days back, although full extract
      "entries": [
        {
          "timestamp": 1637861775,
          "data": {
            "name": "Deadline - DR's video: ",
            "uri": "https://www.facebook.com/DR2Deadline/posts/4458197774227561"
          }
        },
        ...
      ],
    },
    {
      "name": "Websider, du har bes\u00c3\u00b8gt uden for Facebook",
      "description": "Websider, du har bes\u00c3\u00b8gt uden for Facebook i de seneste 90 dage.",
      "entries": [
          {
          "timestamp": 1634927807,
          "data": {
            "name": "dr.dks webside: Alec Baldwin efter skud, der dr\u00c3\u00a6bte filmfotograf: 'Ingen ord kan beskrive mit chok og min sorg'",
            "share": "https://www.dr.dk/nyheder/seneste/alec-baldwin-efter-skud-der-draebte-filmfotograf-ingen-ord-kan-beskrive-mit-chok-og"
          }
        },
        ...
      ],
    },
    {
      "name": "Interaktioner p\u00c3\u00a5 Marketplace",
      "description": "Dine seneste interaktioner p\u00c3\u00a5 Marketplace",
      "children": [
        {
          "name": "Visninger af kategori p\u00c3\u00a5 Marketplace",
          "description": "Datoer, du har f\u00c3\u00a5et vist bestemte kategorier",
          "entries": [
            {
              "data": {
                "value": "29. okt. 2018"
              }
            },
            ...
          ],
        },
        {
          "name": "Varer sl\u00c3\u00a5et op p\u00c3\u00a5 Marketplace",
          "description": "De dage, hvor brugeren slog noget direkte op under fanen",
          "entries": [
            {
              "data": {
                "value": "14. maj 2019"
              }
            }
            ...
          ]
        },
        {
          "name": "Gruppeopslag om varer p\u00c3\u00a5 Marketplace",
          "description": "De dage, hvor brugeren slog varer op i en k\u00c3\u00b8bs- og salgsgruppe. V\u00c3\u00a6rdien g\u00c3\u00a5r kun tilbage til den 27. juni 2019.",
          "entries": [
            {
              "data": {
                "value": "5. aug. 2020"
              }
            },
            {
              "data": {
                "value": "4. aug. 2020"
              }
            }
          ]
        },
        {
          "name": "Krydsopslag med varer p\u00c3\u00a5 Marketplace",
          "description": "De dage, hvor brugeren lavede krydsopslag om varer p\u00c3\u00a5 fanen",
          "entries": [
            {
              "data": {
                "value": "4. aug. 2020"
              }
            }
          ]
        },
        {
          "name": "Beskeder fra k\u00c3\u00b8ber modtaget p\u00c3\u00a5 Marketplace",
          "description": "De dage, hvor s\u00c3\u00a6lgeren modtog de f\u00c3\u00b8rste beskeder fra k\u00c3\u00b8berne",
          "entries": [
            {
              "data": {
                "value": "5. aug. 2020"
              }
            }
          ]
        },
        {
          "name": "S\u00c3\u00b8gninger p\u00c3\u00a5 Marketplace",
          "description": "De dage, brugeren har s\u00c3\u00b8gt p\u00c3\u00a5 Marketplace",
          "entries": [
            {
              "data": {
                "value": "25. sep. 2021"
              }
            },
            ...
          ],
        },
        {
          "name": "Kontaktede s\u00c3\u00a6lgere p\u00c3\u00a5 Marketplace",
          "description": "De dage, hvor brugeren kontaktede s\u00c3\u00a6lgerne",
          "entries": [
            {
              "data": {
                "value": "2. sep. 2020"
              }
            },
            ...
          ],
        },
        {
          "name": "Detaljer om vare p\u00c3\u00a5 Marketplace",
          "description": "Datoer, du har f\u00c3\u00a5et vist detaljer om en vare",
          "entries": [
            {
              "data": {
                "value": "25. sep. 2021"
              }
            },
            ...
          ],
        },
      ],
    },
    {
      "name": "Dine Marketplace-visninger",
      "description": "Datoer, hvor du har f\u00c3\u00a5et vist Marketplace-fanen p\u00c3\u00a5 Facebook",
      "entries": [
        {
          "data": {
            "value": "25. nov. 2021"
          }
        },
        ... // long list with entries for every day you've used the fb app
        {
          "data": {
            "value": "7. sep. 2017"
          }
        },
      ],
    },
    {
      "name": "Varer p\u00c3\u00a5 Marketplace",
      "description": "Varer, du har f\u00c3\u00a5et vist p\u00c3\u00a5 Marketplace",
      "entries": [
        {
          "timestamp": 1632565137,
          "data": {
            "name": "Kommode",
            "uri": "https://www.facebook.com/marketplace/item/1805881166280646/"
          }
        },
        ...
      ],
    },
],
{
  "name": "P\u00c3\u00a5mindelser om opslag, du har gemt",
  "description": "P\u00c3\u00a5mindelser, du har modtaget, efter du har gemt et opslag",
  "entries": [
    {
      "timestamp": 1553415085,
      "data": {
        "value": "P\u00c3\u00a5mindelser af typen F\u00c3\u00a5 styr p\u00c3\u00a5 sagerne med samlinger! vist."
      }
    }
  ]
},
{
  "name": "Annoncer",
  "description": "Annoncer, du har set for nylig",
  "entries": [
    {
      "timestamp": 1637861380,
      "data": {
        "name": "Annonce af TV 2 ZULU",
        "uri": "https://www.facebook.com/tv2zulu/posts/10157912241921783"
      }
    },
    ...
  ],
}
    
```

## Instagram

### your_topics/emoji_sliders.json
```json
{
  "story_activities_emoji_sliders": [
    {
      "title": "lvolinsta",
      "media_list_data": [
        
      ],
      "string_list_data": [
        {
          "href": "",
          "value": "",
          "timestamp": 1543621647
        }
      ]
    },
    ...
  ]
}
```

### ads_and_content/posts_viewed

```json
{
  "impressions_history_posts_seen": [
    {
      "title": "",
      "media_map_data": {
        
      },
      "string_map_data": {
        "Forfatter": {
          "href": "",
          "value": "simonwickx",
          "timestamp": 0
        },
        "Tidspunkt": {
          "href": "",
          "value": "",
          "timestamp": 1623080933
        }
      }
    },
    ...
  ]
}
```

### ads_and_content/videos_watched

```json
{
  "impressions_history_videos_watched": [
    {
      "title": "",
      "media_map_data": {
        
      },
      "string_map_data": {
        "Forfatter": {
          "href": "",
          "value": "nowness",
          "timestamp": 0
        },
        "Tidspunkt": {
          "href": "",
          "value": "",
          "timestamp": 1623081087
        }
      }
    },
    ...
  ]
}
```

### likes/liked_comments.json
```json
{
  "likes_comment_likes": [
    {
      "title": "fortslurpy",
      "media_list_data": [
        
      ],
      "string_list_data": [
        {
          "href": "https://www.instagram.com/p/B5ncH-VH1aT/",
          "value": "\u00f0\u009f\u0091\u008d",
          "timestamp": 1575493409
        }
      ]
    },
  ]
}
```

### likes/liked_posts.json
```json
{
  "likes_media_likes": [
    {
      "title": "shinson_hapkido_holbaek",
      "media_list_data": [
        
      ],
      "string_list_data": [
        {
          "href": "https://www.instagram.com/p/B-kGwM4lIkX/",
          "value": "\u00f0\u009f\u0091\u008d",
          "timestamp": 1586014496
        }
      ]
    },
    ...
  ]
}
```
