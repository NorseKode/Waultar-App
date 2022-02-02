# Content examples from data
Excerpts from the json files, on how different contents are structured

## Facebook

### your_places/places_you've_created

```json
{
  "your_places_v2": [
      {
      "name": "Kastrup Lufthavn",
      "coordinate": {
        "latitude": 55.377719979785,
        "longitude": 10.356211848567
      },
      "address": "Odense",
      "url": "https://www.facebook.com/292989704166140",
      "creation_timestamp": 1365604598
    },
    ...
  ]
}
```

### events/event_invitations

```json
{
  "events_invited_v2": [
      {
      "name": "The Future of Work: Is the Next Normal going to be your New Normal?",
      "start_timestamp": 1604592000,
      "end_timestamp": 1604595600
    },
    ...
    
  ]
}
```

### events/your_event_responses

```json
{
  "event_responses_v2": {
    "events_joined": [
      {
        "name": "Kanotur",
        "start_timestamp": 1628841600,
        "end_timestamp": 0
      },
      ...
      {
        "name": "Poker Night hos g\u00c3\u00a5sen",
        "start_timestamp": 1489856400,
        "end_timestamp": 0,
        "place": {
          "name": "Brol\u00c3\u00b8kkevej 54",
          "coordinate": {
            "latitude": 55.38192,
            "longitude": 10.34847
          }
        },
        "description": "Guys, hvis I har tid l\u00c3\u00b8rdag aften, og der er nok opbakning omkring det, vil jeg gerne invitere jer til pokeraften hos mig den f\u00c3\u00b8rn\u00c3\u00a6vnte dag/nat. I kan bare komme n\u00c3\u00a5r I lyster - jeg besidder ikke selv poker equipment, s\u00c3\u00a5 nogen m\u00c3\u00a5 medbringe dette .. ( Borch og Lund ) \nHvis I har lyst til at spise hos mig, s\u00c3\u00a5 sig lige til. Jeg er alene hjemme hele weekenden. \n\nYours sincerely,\nGus Hansen",
        "create_timestamp": 1489524301
      },
    ],
    "events_declined": [
      {
        "name": "Havnefestival",
        "start_timestamp": 1625914800,
        "end_timestamp": 0
      },
      ...
    ],
    "events_interested": [
      {
        "name": "Elder Island - VEGA",
        "start_timestamp": 1573063200,
        "end_timestamp": 1573074000
      },
      ...
    ]
  }
}
```

### facebook_payments/payment_history

```json
{
  "payments_v2": {
    "preferred_currency": "DKK",
    "payments": [
      // no payments in our own data extracts
    ]
  }
}
```

### pages/pages_you_follow

```json
{
  "pages_followed_v2": [
    {
      "timestamp": 1258639972,
      "data": [
        {
          "name": "Mick \u00c3\u0098gendahl"
        }
      ],
      "title": "Mick \u00c3\u0098gendahl"
    },
    ...
  ]
}
```

### pages/pages_you've_liked

```json
{
  "page_likes_v2": [
    {
      "name": "Bernard Marr",
      "timestamp": 1614201943
    },
    ...
  ]
}
```

### pages/pages_you've_unfollowed

```json
{
  "pages_unfollowed_v2": [
    {
      "timestamp": 1429731132,
      "data": [
        {
          "name": "MyPower - aftenhold"
        }
      ],
      "title": "MyPower - aftenhold"
    },
    ...
  ]
}
```

### groups/your_group_membership_activity

```json
{
  "groups_joined_v2": [
      {
      "timestamp": 1315849708,
      "title": "Du blev medlem af Frem U13 11/12."
    },
    ...
  ]
}
```

### groups/creator_badges

```json
{
  "group_badges_v2": {
    "SM\u00c3\u0098LFANE P\u00c3\u0085 DEN R\u00c3\u0098DE FR\u00c3\u0086KKERT": [
      "Administrator"
    ],
    ...
  }
}
```

### pages/your_pages

```json
{
  "pages_v2": [
    {
      "name": "SM\u00c3\u0098LFANE P\u00c3\u0085 DEN R\u00c3\u0098DE KNALLERT",
      "timestamp": 1605742803,
      "url": "https://www.facebook.com/SM\u00c3\u0098LFANE-P\u00c3\u0085-DEN-R\u00c3\u0098DE-KNALLERT-305233222829421/"
    },
    ...
  ]
}
```

### notifications/notifications

```json
{
  "notifications_v2": [
    {
      "timestamp": 1637909732,
      "unread": true,
      "href": "https://www.facebook.com/groups/itu.student.jobs/?multi_permalinks=1275763649590556%2C1275241956309392%2C1275227719644149%2C1275220379644883%2C1275176616315926",
      "text": "Du har nye opslag i ITU Students - Jobs & Internships."
    },
    ...
  ]
}
```

### other_activity/interactive_videos

```json
{
  "video_polls_v2": [
    {
      "timestamp": 1637861466,
      "title": "Gustav Johansen har deltaget i meningsm\u00c3\u00a5lingen Tror du, Kevin savner G\u00c3\u00bcnther?"
    }
  ]
}
```

### other_activity/pokes

```json
{
  "pokes_v2": [
    {
      "poker": "Frederik Thorsted S\u00c3\u00b8rensen",
      "pokee": "Gustav Johansen",
      "rank": 0,
      "timestamp": 1310556434
    },
    ...
    {
      "poker": "Theo Ellegaard",
      "pokee": "Gustav Johansen",
      "rank": 1,
      "timestamp": 1439541360
    }
  ]
}
```

### saved_items_and_collections/saved_items_and_collections

```json
{
  "saves_and_collections_v2": [
    {
      "timestamp": 1429824082,
      "title": "Gustav Johansen har gemt en video."
    },
    ...
    {
      "timestamp": 1439403141,
      "title": "Gustav Johansen har gemt en video fra Daniel Egelunds opslag."
    },
    ...
    {
      "timestamp": 1442398329,
      "attachments": [
        {
          "data": [
            {
              "external_context": {
                "name": "Er IT-selskaberne blevet uovervindelige?",
                "source": "Marketnews Login",
                "url": "http://marketnews.dk/opinion/blogs/view/17/3528/er_it-selskaberne_blevet_uovervindelige.html"
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har gemt et link fra B\u00c3\u00b8rsens opslag."
    },
    ...
    {
      "timestamp": 1457383850,
      "attachments": [
        {
          "data": [
            {
              "external_context": {
                "name": "https://media.giphy.com/media/3ornka5PILdTZXf0Sk/giphy.gif",
                "url": "https://media.giphy.com/media/3ornka5PILdTZXf0Sk/giphy.gif"
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har gemt et link."
    },
    ...
    {
      "timestamp": 1516480459,
      "attachments": [
        {
          "data": [
            {
              "external_context": {
                "name": "Maybe Mom SA"
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har gemt en side."
    },
    ...
    {
      "timestamp": 1561141389,
      "attachments": [
        {
          "data": [
            {
              "name": "M\u00c3\u00b8bler"
            }
          ]
        }
      ],
      "title": "Gustav Johansen har oprettet en ny samling: M\u00c3\u00b8bler."
    },
    ...
    {
      "timestamp": 1569871423,
      "attachments": [
        {
          "data": [
            {
              "event": {
                "name": "Kulturnat p\u00c3\u00a5 ITU: Oplev teknologiens verden",
                "start_timestamp": 1570809600,
                "end_timestamp": 1570827600
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har gemt en begivenhed."
    },
    ...
    {
      "timestamp": 1595257297,
      "attachments": [
        {
          "data": [
            {
              "external_context": {
                "name": "Bar O"
              }
            }
          ]
        }
      ],
      "title": "Gustav Johansen har gemt et sted."
    },
    ...



```
