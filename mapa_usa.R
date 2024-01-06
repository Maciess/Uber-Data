##PUNKTY NA MAPIE
#nie dodawalam do mapy paru impostorów ze sri lanki i iranu, nw czy w zbiorze danych zostawiac czy tez wywalac
#wiekszosc jest, ale niektore lokalizacje jakies niejasne byly
#drogi sie da dodac, ale nw czy by wtedy nie bylo nieczytelne

install.packages(c("leaflet", "sf"))
install.packages("maps")
library(leaflet)
library(sf)
library(maps)

usa_states <- st_as_sf(map("usa", fill = TRUE, plot = FALSE))

miasta_usa <- data.frame(
  Miasto = c("Fort Pierce", "West Palm Beach", "Cary", "New York", "Elmhurst","Midtown","East Harlem","Flatiron District","Midtown East"
             ,"Hudson Square","Lower Manhattan","Hell's Kitchen","Gulfton","Houston","Eagan Park","Morrisville","Durham","Farmington Woods","Whitebridge","Lake Wellingborough","Fayetteville Street","Raleigh","Hazelwood","Fairmont","Meredith Townes","Apex","Chapel Hill","Northwoods","Edgehill Farms","Tanglewood",
             "Preston","Eastgate","East Elmhust","Jackson Heights","Long Island City","Heritage Pines","Westpark Place","Waverly Place","Wayne Ridge","Weston","East Austin","West University","South Congress","The Drag","Congress Ave District","Red River District","Georgian Acres","North Austin","Coxville","Austin","Katy","Sharpstown","Sugar land","Galveston",
             "Port Bolivar","Washington Avenue","Briar Meadow","Latta","Jacksonville","Couples Glen","Kissimmee","Lake Reams","Orlando","Sand Lake Commons","Sky Lake","Daytona Beach","Ridgeland","Florence","Holly Springs","Chessington","Burtrose","Parkway","McVan","Capitol One","University district","Seattle","Redmont",
             "Bellevue","San Francisco","Palo Alto","Sunnyvale","Newark","Menlo Park","Old city","Savon Height","Kilarney Woods","Townes at Everett Crossing","Huntington Woods","Seaport","Medical centre","Rose Hill","Soho","Tribeca","Financial district","Oakland","Emeryville","Berkeley","Kenner","CBD","Lower Garden District","Lakeview",
             "Storyville","New Orleans","Metairie","Chalmette","Arabi","Pontchartrain Shores","Marigny","Covington","Mandrville","Jamestown Court","Summerwinds","Parkwood","Pontchartrain Beach","St Thomas","Banner Elk","Elk Park","Newland","Boone","Stonewater","Arlington Park at Amberly","
              Kalorama Triangle Historic District","K Street","Connecticut Avenue","Columbia Heights","Wake Forest","West Berkeley","San Jose","Winston Salem","Asheville","Topton","Hayesville","Bryson City","Almond","Mebane","Renaissance","Santa Clara","Ingleside","Tenderloin",
             "College Avenue","South","Southside","Mountain View","El Cerrito","Krendle Woods","Fuquay-Varina"),
  Longitude = c(-80.21, -80.0549, -78.4652, -74.0021, -87.9403,-73.9828,-74.00,-73.9897,-73.976,-74.006,-74.0119,-73.993,-95.48036,-95.2259,-84.4316,-78.4944,-78.54,-78.7734,-78.849,-78.7632,-78.6394,-78.3841,-90.2123,-80.0836,-78.6903,-78.85, -79.0545,-78.7771,-78.803,-95.46307,
                -111.8778,-122.119,-73.8788,-73.884,-73.95,-82.6245, -78.8691,-78.7773,-78.7311,-80.3997,-97.7165,-97.7465,-97.775,-97.742,-97.74284,-97.7349,-97.701,-97.6968,-97.679,-97.75032,-95.82916,-95.5215,-95.6228,-94.7984,-94.7662,-73.9645,-95.51749,-79.4316,-81.6639,-81.91639,
                -81.4089,-81.5699,-81.3845,-81.4781,-81.3926,-81.024,-80.9786,-79.768,-78.83,-78.8526,-78.78678,-78.829,-122.289, -122.369,-122.3045,-122.329,-122.05,-122.201,-122.425,-122.125,-122.0252,-122.0382,-122.179,-75.142288,-78.7989,-78.822,-78.8497,-83.16376,-74.0028,-73.975,-73.983,-74.0011,-74.008,-74.0087,
                -74.24,-122.303,-122.272,-90.255,-90.072,-90.069,-90.107,-90.072,-89.912,-90.1542,-89.963,-90.002,-90.155,-90.056,-90.1,-90.064,-84.4578,-78.768,-78.9,-90.05,-90.069,-81.872,-81.97,-81.926,-81.67,-78.9,-78.909,-77.045,-77.041,-77.037,-77.029,-78.515,-122.29,-121.88,-80.245,-82.554,-83.7,-83.818,-83.449,
                -83.565,-79.27,-78.948,-121.97,-122.46,-122.41,-122.423,-122.41,-122.25,-122.08,-122.3,-78.784,-78.79),
  Latitude = c(27.28, 26.7087, 35.4729, 40.4251, 41.8994,40.7511,40.43,40.741,40.7535,40.7268,40.7078,40.763,29.72756,29.4546,33.6645,35.4939,35.5843,35.7601,35.7865,35.7493,35.7737,35.4908,38.4646,39.2853,35.8222,35.73142,35.91,35.7982,35.7818,29.75025,
               42.095,47.5696,40.76657,40.7559,40.7426,28.425,35.7847,35.7383,35.76365,26.09926,30.2668,30.2883,30.2049,30.2883,30.268,30.2692,30.3502,30.3980,30.40092,30.27058,29.78657,29.705145,29.59853,29.30206,29.385762,40.6815,29.7314,34.33757,30.3457,28.9314,
               28.297,28.4416,28.53,28.43,28.4565,29.2057,32.4856,34.19,35.65429,35.832,35.7729,35.761,47.4508,47.5209,47.6586,47.597646,47.7078,47.6061,37.7677,37.44,37.37279,37.5284,37.450488,39.9525,35.7717,35.75796,35.86138,42.48016,40.7063,40.7415,40.7427,40.7234,40.7173,40.7072,
               41.031,37.838,37.8734,30.007,29.95,29.933,30.0077,29.955,30.0447,29.989,29.94,29.955,30.02,29.965,30.474,30.3567,33.637,35.74,35.896,30.0342,29.925,36.162,36.1579,36.085,36.212,35.845,35.823,38.913,38.9,38.89,38.928,35.976,37.874,37.308,36.089,35.561,35.246,35.045,35.428,
               35.369,36.09,35.9,37.359,37.72,37.783,37.734,37.648,37.867,37.398,37.917,35.785,35.589)
)


miasta_usa = miasta_usa[-which(miasta_usa$Miasto=="Preston"),]
miasta_usa = miasta_usa[-which(miasta_usa$Miasto=="Hazelwood"),]
miasta_usa = miasta_usa[-which(miasta_usa$Miasto=="Huntington Woods"),]
miasta_usa = miasta_usa[-which(miasta_usa$Miasto=="Elmhurst"),]

miasta_usa_sf <- st_as_sf(miasta_usa, coords = c("Longitude", "Latitude"), crs = 4326)

mapa_usa <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = usa_states, fillOpacity = 0.3)

mapa_usa <- mapa_usa %>%
  addMarkers(data = miasta_usa_sf, popup = ~Miasto)
mapa_usa