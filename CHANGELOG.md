## 0.0.10 (12th December 2014)

Features:

- Added VenueNotices model so that information such as closures can be added to a Venue.

## 0.0.9 (1st December 2014)

Features:

- Added acts-as-taggable-on gem
- Opportunities index display now handles HTML based descriptions.
- Tags added to Opportunities
- ASV importer now adds a default set of tags to opportunities

## 0.0.8 (18th October 2014)

Features:

- Added Effort Rating model so that Opportunities can have their sweat level rated.

## 0.0.7 (6th October 2014)

Features:

 - created_at and updated_at now included in Region collection JSON
 - created_at and updated_at now included in Venue collection JSON
 - API docs updated with additional information for Region

## 0.0.6 (5th October 2014)

Features:

 - source_reference field added to Opportunties for storing unique ID as used by the orginal source data
 - source_reference field added to Venues for storing unique ID as used by the orginal source data
 - Opportunities can now be filtered by Region.

## 0.0.5 (4th October 2014)

Features:

 - Venues can now be filtered by Region
 - Edinburgh Sports and Recreational Facilities can now be imported

## 0.0.4 (29th September 2014)

Features:

 - Added Region model so that venues can be filter by different parts of the UK.
 - Opportunities can now be filtered by venue.
 - Opportunities index now takes an optional since paramaters to allow only updated opportunities to be returned.
 - Opportunity JSON object now includes parent Activity, SubActivity and Venue objects.
 - Venue JSON object now included parent Region object.
 - Opportunitiy now has an added image_url field that links to an image associated with it.

## 0.0.3 (12th July 2014)

Features:

 - Added introductory developer API page.
 - Venues index now takes an optional since paramaters to allow only updated venues to be returned.

## 0.0.2 (8th July 2014)

Features:

 - Welcome screen now has direct link to entire Sub Activties list in the welcome text.
 - Sub Activity view now displays list of places to do the activity.

Bugfixes:

 - map now displays correctly for each venue. Thanks to [Dave Morrison](https://github.com/davemor) for providing the solution.

## 0.0.1 (22nd June 2014)

Features:

  - initial version

Bugfixes:

  - none as initial version


