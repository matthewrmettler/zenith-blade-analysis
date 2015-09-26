# zenith-blade-analysis
Repo containing code written for my blog, Zenith Blade

#Data collection
In order to look at or analyze the data, we need to get it, first! For basically any project moving forward,
my approach follows these steps:
1.) Populate the league table with the seed IDs
2.) Sample random users in the league table and get their matchlist
3.) Sample their matchlist, get a list of summoner IDs from those matches
4.) Sample those match summoner IDs, use their IDs to append rows to the league table

In general, the 'league table' is stored longterm (as in, for the life of that project, as this table changes every second). The actual match history or matchlist data is not saved.