# Content examples from data
Excerpts from the json files, on how different contents are structured

## Facebook

### comments_and_reactions\posts_and_comments.json
Might be changed to content later (likes and so on)

Note it's the reaction that can change
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
        {
        "timestamp": 1610713072,
        "data": [
            {
            "reaction": {
                "reaction": "HAHA",
                "actor": "Lukas Vinther Offenberg Larsen"
            }
            }
        ],
        "title": "Lukas Vinther Offenberg Larsen reacted to Mathias Rasmus Nielsen's comment."
        },
    ]
}
```