# Unit Description

---

## Overview
When passing units through the interface, the unit format requirements are as follows:
<br/>
Unit format: custom/["unit type","unit"], example: custom/["time","ms"]
<br/>
Custom unit format: custom/["custom","custom unit"], example: custom/["custom","tt"]
<br/>

The information for unit types and units is as follows:
```json
[
    {
        "value": "digital",
        "label": "Data Size",
        "children": [
            {
                "value": "b",
                "label": "b",
                "__label": "Data Size / b",
                "__value": "digital,b"
            },
            {
                "value": "Kb",
                "label": "Kb",
                "__label": "Data Size / Kb",
                "__value": "digital,Kb"
            },
            {
                "value": "Mb",
                "label": "Mb",
                "__label": "Data Size / Mb",
                "__value": "digital,Mb"
            },
            {
                "value": "Gb",
                "label": "Gb",
                "__label": "Data Size / Gb",
                "__value": "digital,Gb"
            },
            {
                "value": "Tb",
                "label": "Tb",
                "__label": "Data Size / Tb",
                "__value": "digital,Tb"
            },
            {
                "value": "Pb",
                "label": "Pb",
                "__label": "Data Size / Pb",
                "__value": "digital,Pb"
            },
            {
                "value": "Eb",
                "label": "Eb",
                "__label": "Data Size / Eb",
                "__value": "digital,Eb"
            },
            {
                "value": "Zb",
                "label": "Zb",
                "__label": "Data Size / Zb",
                "__value": "digital,Zb"
            },
            {
                "value": "Yb",
                "label": "Yb",
                "__label": "Data Size / Yb",
                "__value": "digital,Yb"
            },
            {
                "value": "B",
                "label": "B",
                "__label": "Data Size / B",
                "__value": "digital,B"
            },
            {
                "value": "KB",
                "label": "KB",
                "__label": "Data Size / KB",
                "__value": "digital,KB"
            },
            {
                "value": "MB",
                "label": "MB",
                "__label": "Data Size / MB",
                "__value": "digital,MB"
            },
            {
                "value": "GB",
                "label": "GB",
                "__label": "Data Size / GB",
                "__value": "digital,GB"
            },
            {
                "value": "TB",
                "label": "TB",
                "__label": "Data Size / TB",
                "__value": "digital,TB"
            },
            {
                "value": "PB",
                "label": "PB",
                "__label": "Data Size / PB",
                "__value": "digital,PB"
            },
            {
                "value": "EB",
                "label": "EB",
                "__label": "Data Size / EB",
                "__value": "digital,EB"
            },
            {
                "value": "ZB",
                "label": "ZB",
                "__label": "Data Size / ZB",
                "__value": "digital,ZB"
            },
            {
                "value": "YB",
                "label": "YB",
                "__label": "Data Size / YB",
                "__value": "digital,YB"
            }
        ]
    },
    {
        "value": "time",
        "label": "Time Interval",
        "children": [
            {
                "value": "ns",
                "label": "ns",
                "__label": "Time Interval / ns",
                "__value": "time,ns"
            },
            {
                "value": "μs",
                "label": "μs",
                "__label": "Time Interval / μs",
                "__value": "time,μs"
            },
            {
                "value": "ms",
                "label": "ms",
                "__label": "Time Interval / ms",
                "__value": "time,ms"
            },
            {
                "value": "s",
                "label": "s",
                "__label": "Time Interval / s",
                "__value": "time,s"
            },
            {
                "value": "min",
                "label": "min",
                "__label": "Time Interval / min",
                "__value": "time,min"
            },
            {
                "value": "h",
                "label": "h",
                "__label": "Time Interval / h",
                "__value": "time,h"
            },
            {
                "value": "d",
                "label": "d",
                "__label": "Time Interval / d",
                "__value": "time,d"
            },
            {
                "value": "week",
                "label": "week",
                "__label": "Time Interval / week",
                "__value": "time,week"
            },
            {
                "value": "month",
                "label": "month",
                "__label": "Time Interval / month",
                "__value": "time,month"
            },
            {
                "value": "year",
                "label": "year",
                "__label": "Time Interval / year",
                "__value": "time,year"
            }
        ]
    },
    {
        "label": "Timestamp",
        "value": "timeStamp",
        "children": [
            {
                "label": "s",
                "value": "s",
                "__label": "Timestamp / s",
                "__value": "timeStamp,s"
            },
            {
                "label": "ms",
                "value": "ms",
                "__label": "Timestamp / ms",
                "__value": "timeStamp,ms"
            },
            {
                "label": "μs",
                "value": "μs",
                "__label": "Timestamp / μs",
                "__value": "timeStamp,μs"
            },
            {
                "label": "ns",
                "value": "ns",
                "__label": "Timestamp / ns",
                "__value": "timeStamp,ns"
            }
        ]
    },
    {
        "label": "Traffic",
        "value": "traffic",
        "children": [
            {
                "label": "B/S",
                "value": "B/S",
                "__label": "Traffic / B/S",
                "__value": "traffic,B/S"
            },
            {
                "label": "KB/S",
                "value": "KB/S",
                "__label": "Traffic / KB/S",
                "__value": "traffic,KB/S"
            },
            {
                "label": "MB/S",
                "value": "MB/S",
                "__label": "Traffic / MB/S",
                "__value": "traffic,MB/S"
            },
            {
                "label": "GB/S",
                "value": "GB/S",
                "__label": "Traffic / GB/S",
                "__value": "traffic,GB/S"
            },
            {
                "label": "TB/S",
                "value": "TB/S",
                "__label": "Traffic / TB/S",
                "__value": "traffic,TB/S"
            }
        ]
    },
    {
        "label": "Bandwidth",
        "value": "bandWidth",
        "children": [
            {
                "label": "bps",
                "value": "bps",
                "__label": "Bandwidth / bps",
                "__value": "bandWidth,bps"
            },
            {
                "label": "Kbps",
                "value": "Kbps",
                "__label": "Bandwidth / Kbps",
                "__value": "bandWidth,Kbps"
            },
            {
                "label": "Mbps",
                "value": "Mbps",
                "__label": "Bandwidth / Mbps",
                "__value": "bandWidth,Mbps"
            },
            {
                "label": "Gbps",
                "value": "Gbps",
                "__label": "Bandwidth / Gbps",
                "__value": "bandWidth,Gbps"
            },
            {
                "label": "Tbps",
                "value": "Tbps",
                "__label": "Bandwidth / Tbps",
                "__value": "bandWidth,Tbps"
            }
        ]
    },
    {
        "value": "percent",
        "label": "Percentage",
        "children": [
            {
                "value": "percent",
                "label": "0 - 100",
                "__label": "Percentage / 0 - 100",
                "__value": "percent,percent"
            },
            {
                "value": "percent_decimal",
                "label": "0.0 - 1.0",
                "__label": "Percentage / 0.0 - 1.0",
                "__value": "percent,percent_decimal"
            }
        ]
    },
    {
        "value": "rmb",
        "label": "Chinese Yuan",
        "children": [
            {
                "value": "yuan",
                "label": "Yuan",
                "__label": "Chinese Yuan / Yuan",
                "__value": "rmb,yuan"
            },
            {
                "value": "wan_yuan",
                "label": "Wan",
                "__label": "Chinese Yuan / Wan",
                "__value": "rmb,wan_yuan"
            },
            {
                "value": "yi_yuan",
                "label": "Yi",
                "__label": "Chinese Yuan / Yi",
                "__value": "rmb,yi_yuan"
            }
        ]
    },
    {
        "value": "currencySymbol",
        "label": "Currency",
        "children": [
            {
                "value": "cny",
                "label": "Chinese Yuan (¥)",
                "__label": "Currency / Chinese Yuan (¥)",
                "__value": "currencySymbol,cny"
            },
            {
                "value": "usd",
                "label": "US Dollar ($)",
                "__label": "Currency / US Dollar ($)",
                "__value": "currencySymbol,usd"
            },
            {
                "value": "eur",
                "label": "Euro (€)",
                "__label": "Currency / Euro (€)",
                "__value": "currencySymbol,eur"
            },
            {
                "value": "gbp",
                "label": "British Pound (£)",
                "__label": "Currency / British Pound (£)",
                "__value": "currencySymbol,gbp"
            },
            {
                "value": "rub",
                "label": "Russian Ruble (₽)",
                "__label": "Currency / Russian Ruble (₽)",
                "__value": "currencySymbol,rub"
            }
        ]
    },
    {
        "value": "frequency",
        "label": "Frequency",
        "children": [
            {
                "value": "mHz",
                "label": "mHz",
                "__label": "Frequency / mHz",
                "__value": "frequency,mHz"
            },
            {
                "value": "Hz",
                "label": "Hz",
                "__label": "Frequency / Hz",
                "__value": "frequency,Hz"
            },
            {
                "value": "kHz",
                "label": "kHz",
                "__label": "Frequency / kHz",
                "__value": "frequency,kHz"
            },
            {
                "value": "MHz",
                "label": "MHz",
                "__label": "Frequency / MHz",
                "__value": "frequency,MHz"
            },
            {
                "value": "GHz",
                "label": "GHz",
                "__label": "Frequency / GHz",
                "__value": "frequency,GHz"
            },
            {
                "value": "THz",
                "label": "THz",
                "__label": "Frequency / THz",
                "__value": "frequency,THz"
            },
            {
                "value": "rpm",
                "label": "rpm",
                "__label": "Frequency / rpm",
                "__value": "frequency,rpm"
            },
            {
                "value": "deg/s",
                "label": "deg/s",
                "__label": "Frequency / deg/s",
                "__value": "frequency,deg/s"
            },
            {
                "value": "rad/s",
                "label": "rad/s",
                "__label": "Frequency / rad/s",
                "__value": "frequency,rad/s"
            }
        ]
    },
    {
        "value": "length",
        "label": "Length",
        "children": [
            {
                "value": "mm",
                "label": "mm",
                "__label": "Length / mm",
                "__value": "length,mm"
            },
            {
                "value": "cm",
                "label": "cm",
                "__label": "Length / cm",
                "__value": "length,cm"
            },
            {
                "value": "m",
                "label": "m",
                "__label": "Length / m",
                "__value": "length,m"
            },
            {
                "value": "km",
                "label": "km",
                "__label": "Length / km",
                "__value": "length,km"
            },
            {
                "value": "in",
                "label": "in",
                "__label": "Length / in",
                "__value": "length,in"
            },
            {
                "value": "yd",
                "label": "yd",
                "__label": "Length / yd",
                "__value": "length,yd"
            },
            {
                "value": "ft-us",
                "label": "ft-us",
                "__label": "Length / ft-us",
                "__value": "length,ft-us"
            },
            {
                "value": "ft",
                "label": "ft",
                "__label": "Length / ft",
                "__value": "length,ft"
            },
            {
                "value": "mi",
                "label": "mi",
                "__label": "Length / mi",
                "__value": "length,mi"
            }
        ]
    },
    {
        "value": "angle",
        "label": "Angle",
        "children": [
            {
                "value": "rad",
                "label": "rad",
                "__label": "Angle / rad",
                "__value": "angle,rad"
            },
            {
                "value": "deg",
                "label": "deg",
                "__label": "Angle / deg",
                "__value": "angle,deg"
            },
            {
                "value": "grad",
                "label": "grad",
                "__label": "Angle / grad",
                "__value": "angle,grad"
            },
            {
                "value": "arcmin",
                "label": "arcmin",
                "__label": "Angle / arcmin",
                "__value": "angle,arcmin"
            },
            {
                "value": "arcsec",
                "label": "arcsec",
                "__label": "Angle / arcsec",
                "__value": "angle,arcsec"
            }
        ]
    },
    {
        "value": "mass",
        "label": "Mass",
        "children": [
            {
                "value": "mcg",
                "label": "mcg",
                "__label": "Mass / mcg",
                "__value": "mass,mcg"
            },
            {
                "value": "mg",
                "label": "mg",
                "__label": "Mass / mg",
                "__value": "mass,mg"
            },
            {
                "value": "g",
                "label": "g",
                "__label": "Mass / g",
                "__value": "mass,g"
            },
            {
                "value": "kg",
                "label": "kg",
                "__label": "Mass / kg",
                "__value": "mass,kg"
            },
            {
                "value": "mt",
                "label": "mt",
                "__label": "Mass / mt",
                "__value": "mass,mt"
            },
            {
                "value": "oz",
                "label": "oz",
                "__label": "Mass / oz",
                "__value": "mass,oz"
            },
            {
                "value": "lb",
                "label": "lb",
                "__label": "Mass / lb",
                "__value": "mass,lb"
            },
            {
                "value": "t",
                "label": "t",
                "__label": "Mass / t",
                "__value": "mass,t"
            }
        ]
    },
    {
        "label": "Number",
        "value": "number",
        "children": [
            {
                "label": "Ten Thousand Scale",
                "value": "default",
                "__label": "Number / Ten Thousand Scale",
                "__value": "number,default"
            },
            {
                "label": "Short Scale",
                "value": "short_scale",
                "__label": "Number / Short Scale",
                "__value": "number,short_scale"
            }
        ]
    },
    {
        "value": "speed",
        "label": "Speed",
        "children": [
            {
                "value": "m/s",
                "label": "m/s",
                "__label": "Speed / m/s",
                "__value": "speed,m/s"
            },
            {
                "value": "km/h",
                "label": "km/h",
                "__label": "Speed / km/h",
                "__value": "speed,km/h"
            },
            {
                "value": "m/h",
                "label": "m/h",
                "__label": "Speed / m/h",
                "__value": "speed,m/h"
            },
            {
                "value": "knot",
                "label": "knot",
                "__label": "Speed / knot",
                "__value": "speed,knot"
            },
            {
                "value": "ft/s",
                "label": "ft/s",
                "__label": "Speed / ft/s",
                "__value": "speed,ft/s"
            }
        ]
    },
    {
        "value": "temperature",
        "label": "Temperature",
        "children": [
            {
                "value": "C",
                "label": "C",
                "__label": "Temperature / C",
                "__value": "temperature,C"
            },
            {
                "value": "K",
                "label": "K",
                "__label": "Temperature / K",
                "__value": "temperature,K"
            },
            {
                "value": "F",
                "label": "F",
                "__label": "Temperature / F",
                "__value": "temperature,F"
            },
            {
                "value": "R",
                "label": "R",
                "__label": "Temperature / R",
                "__value": "temperature,R"
            }
        ]
    },
    {
        "value": "throughput",
        "label": "Throughput",
        "children": [
            {
                "value": "ops",
                "label": "ops",
                "__label": "Throughput / ops",
                "__value": "throughput,ops"
            },
            {
                "value": "reqps",
                "label": "reqps",
                "__label": "Throughput / reqps",
                "__value": "throughput,reqps"
            },
            {
                "value": "readps",
                "label": "readps",
                "__label": "Throughput / readps",
                "__value": "throughput,readps"
            },
            {
                "value": "wps",
                "label": "wps",
                "__label": "Throughput / wps",
                "__value": "throughput,wps"
            },
            {
                "value": "iops",
                "label": "iops",
                "__label": "Throughput / iops",
                "__value": "throughput,iops"
            },
            {
                "value": "opm",
                "label": "opm",
                "__label": "Throughput / opm",
                "__value": "throughput,opm"
            },
            {
                "value": "readpm",
                "label": "readpm",
                "__label": "Throughput / readpm",
                "__value": "throughput,readpm"
            },
            {
                "value": "wpm",
                "label": "wpm",
                "__label": "Throughput / wpm",
                "__value": "throughput,wpm"
            }
        ]
    },
    {
        "value": "custom",
        "label": "Custom",
        "__label": "Custom",
        "__value": "custom"
    }
]
```