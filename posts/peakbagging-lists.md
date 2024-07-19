I just moved to Washington, and peakbagging is pretty big here. Alot of times this takes the form of trying to check off a list of peaks from peakbagger.com. I'm thinking about attempting the [Alpine lakes home court 100](https://www.peakbagger.com/list.aspx?lid=21307), but I'd like to see all the points on a map first, which means a gpx file of waypoints for each peak. Luckily, this is super easy to do! Here's a python script I wrote that does it, feel free to use it (although obviously refrain from scraping more than one list at a time for overuse of API reasons):

    import requests
    import re

    list_id = 21307
    
    class Peak:
        def __init__(self, name, elevation, latitude, longitude):
            self.name = name
            self.elevation = elevation
            self.latitude = latitude
            self.longitude = longitude

        def __str__(self):
            return f"{self.name} is {self.elevation} feet tall and is located at {self.latitude}, {self.longitude}"

    def get_peak_list_data(list_id: int):
        url = f"https://www.peakbagger.com/list.aspx?lid={list_id}"
        response = requests.get(url)

        t = response.text
        open('src.html', 'w').write(t)
        ids = [str(x).replace("peack.aspx?pid=","") for x in  re.findall(r'peak\.aspx\?pid=(\d+)', t)]
        list_name = str(re.findall(r'<h1>([^<]+)</h1>', t)[0])

        return ids, list_name.replace("<h1>","").replace("</h1>","")


    def scrape_peak(peak_id: int):
        url = f"https://www.peakbagger.com/peak.aspx?pid={peak_id}"
        response = requests.get(url)
        t = response.text
        open('src.html', 'w').write(t)

        name = str(re.findall(r'<h1>([^<]+)</h1>', t)[0]).replace("<h1>","").replace("</h1>","")
        elevation = 0
        latitude,longitude = str(re.findall(r'([\d\.-]+, [\d\.-]+) \(Dec Deg\)', t)[0]).split(", ")

        return Peak(name, elevation, latitude, longitude)


    def generate_gpx_data(peaks: list[Peak], list_name: str):
        d = f'''<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
        <gpx xmlns="http://www.topografix.com/GPX/1/1" version="1.1" creator="Wikipedia"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
        <metadata>
        <name>Peakbagger List: {list_name}</name>
        <desc>An export of all the peaks in peakbagger list: {list_name}</desc>
        <author>
        <name>Peakbagger Xxport</name>
        </author>
        </metadata>'''

        for peak in peaks:
            # <ele>{peak.elevation}</ele>
            d += f'''
            <wpt lat="{peak.latitude}" lon="{peak.longitude}">
            <name>{peak.name}</name>
            </wpt>
            '''

        d += "</gpx>"

        return d


    ids,name = get_peak_list_data(list_id)
    peaks = [scrape_peak(x) for x in ids]

    open(f"{name}.gpx", "w").write(generate_gpx_data(peaks, name))


