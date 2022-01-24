# Content examples from data
Excerpts from the json files, on how different contents are structured

## Facebook

### news_feed\news_feed.json
```json
{
  "people_and_friends_v2": [
    {
      "name": "Favourites",
      "description": "Friends and Pages whose posts you've prioritised in your News Feed",
      "entries": [
        {
          "timestamp": 1485723826,
          "data": {
            "name": "DR Ekstremsport",
            "uri": "https://www.facebook.com/drekstremsport/"
          }
        }
      ]
    }
  ]
}
```

### preferences\language_and_locale.json
```json
{
  "language_and_locale_v2": [
    {
      "name": "Language settings",
      "description": "Your preferred language settings",
      "children": [
        {
          "name": "Selected language",
          "description": "The language that you've chosen for your Facebook experience",
          "entries": [
            {
              "data": {
                "value": "en_GB"
              }
            }
          ]
        },
        {
          "name": "Locale changes",
          "description": "The history of changes to your locale setting",
          "entries": [
            {
              "timestamp": 1603917932,
              "data": {
                "name": "en_GB"
              }
            }
          ]
        }
      ]
    },
    {
      "name": "Preferred language for videos",
      "description": "The preferred language for videos, as determined by videos you've previously viewed",
      "entries": [
        {
          "data": {
            "value": "da"
          }
        }
      ]
    },
    {
      "name": "Languages you may know",
      "description": "Languages you may know as determined by your activity on Facebook",
      "entries": [
        {
          "data": {
            "value": "da"
          }
        },
        {
          "data": {
            "value": "en"
          }
        }
      ]
    },
    {
      "name": "Preferred language",
      "description": "Your preferred languages as determined by your activity on Facebook",
      "entries": [
        {
          "data": {
            "value": "da_DK"
          }
        }
      ]
    }
  ]
}
```
