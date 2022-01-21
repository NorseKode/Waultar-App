# Content examples from data
Excerpts from the json files, on how different contents are structured

## Facebook

### friends_and_followers/
All friends follow the same pattern
Includes
- friends.json
- friend_requests_received.json
- friend_requests_sent.json
- rejected_friend_requests.json
- removed_friends.json

```json
{
    "friends_v2": [
        {
            "name": "Mads Br\u00c3\u00b8ndum",
          "timestamp": 1634498460
        },
    ...
  ]
}
```

### friends_and_followers/who_you_follow.json
```json
{
  "following_v2": [
    {
      "name": "R\u00c3\u00b8rvig Dessert",
      "timestamp": 1628255908
    },
  ]
}
```

## Instagram

### followers_and_following/followers.json
```json
{
  "relationships_followers": [
    {
      "title": "",
      "media_list_data": [
        
      ],
      "string_list_data": [
        {
          "href": "https://www.instagram.com/kevinkapanya",
          "value": "kevinkapanya",
          "timestamp": 1608833534
        }
      ]
    },
    ...
  ]
}
```

### followers_and_following/following.json
```json
{
  "relationships_following": [
    {
      "title": "",
      "media_list_data": [
        
      ],
      "string_list_data": [
        {
          "href": "https://www.instagram.com/itustudent",
          "value": "itustudent",
          "timestamp": 1635758156
        }
      ]
    },
    ...
  ]
}
```
