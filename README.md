# Community Sentiment
Source code for a week long studio project in fall, 2015. 
MGD @ COD, NCSU

The idea was to display community sentiment in public, so both the community and the policy leaders have an idea about what the people around them are feeling. For the show-and-tell, I ran the source on four mid-sized TV screens in our studio, and on one huge display in the center. The client was distributed to each student and they could participate in the exercise. As they send messages to the server they choose (LV / LT / RV / RT), the visuals on the displays change, reflecting the general sentiment of the communities. The visuals are kept abstract for privacy purposes.

The codebase has several processing sketches. These are either for various servers, or for a client.
- ClientPanda is the client that connects to LV / LT / RV / RT servers. This is what the masses would use.
- LV / LT / RV / RT act as servers for the end-user client (ClientPanda) and as clients for the MasterServer. These are made for medium-sized public displays that would display the information for each sub-community locally.
- MasterServer acts as the server for LV / LT / RV / RT, and is meant for a big public display that would visualize the sentiment of the whole community.
