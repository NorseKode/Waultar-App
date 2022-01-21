# Overview 
Quick overview of common structure of the content part of the data model

# Categories for the data

## Media
Files, videos, stickers, images etc. are all placed in one folder and their path from root extraction folder referenced from the json files.

### Facebook
Typically structured in a data element like the following
```json
{
    "timestamp": 1273171899,
    "attachments": [
    {
        "data": [
        {
            "media": {
            "uri": "posts/media/MobileUploads_LvJWqglAvA/28819_1251667781858_646231_n_1251667781858.jpg",
            "creation_timestamp": 1273171899,
            "title": "Mobile Uploads",
            "description": "Tja hvad skal man sige"
            }
        }
        ]
    }
    ],
    "data": [
    {
        "post": "Tja hvad skal man sige"
    }
    ],
    "title": "Lukas Vinther Offenberg Larsen added a new photo."
}
```

With the possibility for image, video and external content

```json
"media": {
    "uri": "posts/media/TimelinePhotos_awR520Z08w/226622_1661337463344_5022041_n_1661337463344.jpg",
    "creation_timestamp": 1305050046,
    "media_metadata": {
        "photo_metadata": {
        "exif_data": [
            {
            "upload_ip": "94.145.3.49"
            }
        ]
        }
    },
    "title": "Timeline Photos",
    "description": "Han satte sig ved siden af mig, kan n\u00c3\u00a6sten ikke blive bedre :O)"
}
...
"media": {
    "uri": "posts/media/videos/1199405_10200191443018829_7953_n_2022020720200.mp4",
    "creation_timestamp": 1319393272,
    "media_metadata": {
        "video_metadata": {
        "exif_data": [
            {
            "upload_ip": "94.145.3.49",
            "upload_timestamp": 0
            }
        ]
        }
    },
    "thumbnail": {
        "uri": "https://interncache-eag.fbcdn.net/v/t15.0-10/51259_2022075721575_2022020720200_36271_771_b.jpg?ccb=1-5&_nc_sid=73a6a0&efg=eyJ1cmxnZW4iOiJwaHBfdXJsZ2VuX2NsaWVudC9pbW9nZW46RFlJTWVkaWFVdGlscyJ9&_nc_ad=z-m&_nc_cid=0&_nc_ht=interncache-eag&oh=b58e379b860904abec987a7a7413a6d4&oe=618DF1C4"
    },
    "description": ""
}
...
"external_context": {
    "name": "Klassisk",
    "source": "Spotify",
    "url": "https://open.spotify.com/track/6N3VQTPWepIkkpgHH98ZEh"
}
```

### Instagram

Typically structured in a data element like the following

```json
[   
    {
        "media": [
            {
            "uri": "media/posts/201904/56560768_1970692303053594_6309902514592175656_n_18025938001189213.jpg",
            "creation_timestamp": 1554996051,
            "media_metadata": {
                "photo_metadata": {
                    "exif_data": [
                        {
                        "latitude": 36,
                        "longitude": 128
                        }
                    ]
                }
            },
            "title": "Anyone else feel spring around the corner? \u00f0\u009f\u0099\u008c"
            }
        ]
    },
]
```

With the possibility for image, video and external content
```json
{
    "uri": "media/posts/201904/56560768_1970692303053594_6309902514592175656_n_18025938001189213.jpg",
    "creation_timestamp": 1554996051,
    "media_metadata": {
    "photo_metadata": {
        "exif_data": [
        {
            "latitude": 36,
            "longitude": 128
        }
        ]
    }
    },
    "title": "Anyone else feel spring around the corner? \u00f0\u009f\u0099\u008c"
}
...
{
    "uri": "media/posts/201912/80041955_166699531104799_746025938224980092_n_17856715594629257.mp4",
    "creation_timestamp": 1575388926,
    "media_metadata": {
    "video_metadata": {
        "exif_data": [
        {
            "latitude": 55.71835,
            "longitude": 11.72495
        }
        ]
    }
    },
    "title": "You know if I don't drop the staff, and maybe do my punches more clearly, then it's almost there \u00f0\u009f\u0098\u0082\n#martialarts #tricking #hapkido"
}
...
{
    "external_context": {
        "url": "https://media1.tenor.co/images/9039efd78af386c430259dad871da807/tenor.gif?itemid=4367793"
    }
}
```


## Content
All user generated content for a service - posts, created events, comments etc.

What the actual content contains can vary a lot, so only one example from each are provided. In order to give an basic overview

### Facebook
```json
{
    "timestamp": 1555607877,
    "attachments": [
        {
        "data": [
            {
            "media": {
                "uri": "posts/media/videos/58142129_1044097399122414_2636513323016781824_n_10213265190774352.mp4",
                "creation_timestamp": 1555607885,
                "media_metadata": {
                "video_metadata": {
                    "exif_data": [
                    {
                        "upload_ip": "79.131.50.64",
                        "upload_timestamp": 1555607876
                    }
                    ]
                }
                },
                "thumbnail": {
                "uri": "posts/media/videos/58142129_1044097399122414_2636513323016781824_n_10213265190774352.mp4"
                },
                "description": ""
            }
            }
        ]
        }
    ],
    "data": [
        {
        "comment": {
            "timestamp": 1555607877,
            "comment": "Kim Vinther Larsen Hva'!!! Vi er da meget bedre!!!!!",
            "author": "Lukas Vinther Offenberg Larsen"
        }
        }
    ],
    "title": "Lukas Vinther Offenberg Larsen replied to Kim Vinther Larsen's comment."
}
```

### Instagram
```json
{
    "media": [
    {
        "uri": "media/posts/201912/80041955_166699531104799_746025938224980092_n_17856715594629257.mp4",
        "creation_timestamp": 1575388926,
        "media_metadata": {
        "video_metadata": {
            "exif_data": [
            {
                "latitude": 55.71835,
                "longitude": 11.72495
            }
            ]
        }
        },
        "title": "You know if I don't drop the staff, and maybe do my punches more clearly, then it's almost there \u00f0\u009f\u0098\u0082\n#martialarts #tricking #hapkido"
    }
    ]
}
```

## Activity
Logged info about user activity on a service - places, location, event responses etc.

Are inferred while reading the other data points, so it would be longitude and latitude associated with at post, and so on

## Interactions
User interaction with platform - likes, visited profiles and pages, submits to polls etc.

### Facebook
Seems to vary in the way it handles it, so it varies wether it is a event, poll and so on

### Instagram
Seems to follow the same structure for most of their content, it has the following structure

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
