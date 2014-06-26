## MatchTheCity


Rails based backend for the MatchTheCity project that was created at part of [CodeTheCity Aberdeen 2014](http://codethecity.org)

The purpose of the project is to provide information about various public reoccurring activities in the Aberdeen area.

The ultimate aim is to be able to populate a MatchTheCity server with data for different areas.

### Sample Server


There is a sample server running at [http://matchthecity.herokuapp.com](http://matchthecity.herokuapp.com)

### Importing Data


The default data sets can be imported using the following:

`rake import:aquatics`                    # Import Aberdeen Aquatics Centre Activities

`rake import:asv_sport_activities`        # Import Aberdeen Sports Village Activities

`rake import:skills`                      # Import Soft Skills

`rake import:sport_activities`            # Import Sport Activities

`rake import:venues`            # Import Venues

`rake import:rebuild_all`       # Deletes all existing data and reimports all the data


### Troubleshooting

For help with common problems, see [ISSUES](https://github.com/CodeTheCity/matchthecity/blob/master/ISSUES.md).

### Other questions

To see what has changed in recent versions of MatchTheCity, see the [CHANGELOG](https://github.com/CodeTheCity/matchthecity/blob/master/CHANGELOG.md).

Feel free to contact the MatchTheCity core team via Twitter [@MatchTheCity](https://twitter.com/matchthecity)

### Contributing

If you'd like to contribute to MatchTheCity, that's great. There's a guide to contributing to, both code and general help, over in [CONTRIBUTING](https://github.com/CodeTheCity/matchthecity/blob/master/CONTRIBUTING.md)
