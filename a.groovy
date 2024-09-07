import groovy.json.JsonSlurper
def jsonSlurper = new JsonSlurper()
def object = jsonSlurper.parseText(new File(args[0]).text)

// The Cardinal Creek Map KVM coordinate data
// https://www.google.com/maps/d/edit?mid=1RzJd0YG3sWr_Wbf91xmnV_WS1Yo&usp=sharing
def ccPoly = [
    ["long":-75.47054,   "lat":45.49287],
    ["long":-75.46938,   "lat":45.48619],
    ["long":-75.467234,  "lat":45.485891],
    ["long":-75.46384,   "lat":45.48441],
    ["long":-75.46126,   "lat":45.4827],
    ["long":-75.4538,    "lat":45.4796],
    ["long":-75.43943,   "lat":45.47427],
    ["long":-75.46634,   "lat":45.46738],
    ["long":-75.46754,   "lat":45.46943],
    ["long":-75.46951,   "lat":45.47102],
    ["long":-75.47003,   "lat":45.47253],
    ["long":-75.4701117, "lat":45.47352],
    ["long":-75.46985,   "lat":45.47451],
    ["long":-75.4707554, "lat":45.4746153],
    ["long":-75.47209,   "lat":45.47454],
    ["long":-75.47495,   "lat":45.48065],
    ["long":-75.47629,   "lat":45.48119],
    ["long":-75.47578,   "lat":45.48273],
    ["long":-75.4749604, "lat":45.4834355],
    ["long":-75.4739692, "lat":45.4840809],
    ["long":-75.4753521, "lat":45.4858005],
    ["long":-75.4777067, "lat":45.4889297],
    ["long":-75.47552,   "lat":45.48959],
    ["long":-75.47342,   "lat":45.49106],
    ["long":-75.47277,   "lat":45.49205],
    ["long":-75.47054,   "lat":45.49287],
]

// From: https://stackoverflow.com/questions/14818567/point-in-polygon-algorithm-giving-wrong-results-sometimes/18190354#18190354
boolean isInCC(def poly, def point) {
    int count = 0;
    def p1 = poly[0]
    int n = poly.size()
    for (int i=1; i <= n; i++) {
        def p2 = poly[ i % n ]
        if ( point.x > Math.min(p1.long, p2.long) &&
             point.x <= Math.max(p1.long, p2.long) &&
             point.y <= Math.max(p1.lat, p2.lat) &&
             point.x != p2.long) {
            def xinters = (point.x - p1.long) * (p2.lat - p1.lat) / (p2.long - p1.long) + p1.lat;
            if (p1.lat == p2.lat || point.y <= xinters) {
                count++
            }
        }
        p1 = p2
    }
    return count % 2 != 0
}

// From https://stackoverflow.com/questions/11716268/point-in-polygon-algorithm/15599478#15599478 
boolean isInCC2(def poly, def point) {
  boolean c = false;
  
  int i
  int j
   
  for(i = 0, j = poly.size() - 1; i < poly.size(); j = i++) {
    if( ( (poly[i].lat >= point.y ) != (poly[j].lat >= point.y) ) &&
        (point.x <= (poly[j].long - poly[i].long) * (point.y - poly[i].lat) / (poly[j].lat - poly[i].lat) + poly[i].long)
      )
      c = !c;
  }
  
  return c;
}

[2018, 2019, 2020, 2021, 2022, 2023, 2024].each { year ->
    byYear = object.features.findAll {
        it.attributes.YEAR == year && isInCC(ccPoly, it.geometry)
    }
    byYear2 = object.features.findAll {
        it.attributes.YEAR == year && isInCC2(ccPoly, it.geometry)
    }
    println("${year}: ${byYear.size()} ${byYear2.size()}")
}
