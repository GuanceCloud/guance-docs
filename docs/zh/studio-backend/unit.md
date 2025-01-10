# 单位说明

---

## 概述
通过接口传递单位时, 单位格式要求:
<br/>
单位格式: custom/["单位类型","单位"] , 示列: custom/["time","ms"]
<br/>
自定义单位格式: custom/["custom","自定义单位"], 示列: custom/["custom","tt"]
<br/>

单位类型/单位 信息如下:
```json
[
    {
        "value": "digital",
        "label": "数据大小",
        "children": [
            {
                "value": "b",
                "label": "b",
                "__label": "数据大小 / b",
                "__value": "digital,b"
            },
            {
                "value": "Kb",
                "label": "Kb",
                "__label": "数据大小 / Kb",
                "__value": "digital,Kb"
            },
            {
                "value": "Mb",
                "label": "Mb",
                "__label": "数据大小 / Mb",
                "__value": "digital,Mb"
            },
            {
                "value": "Gb",
                "label": "Gb",
                "__label": "数据大小 / Gb",
                "__value": "digital,Gb"
            },
            {
                "value": "Tb",
                "label": "Tb",
                "__label": "数据大小 / Tb",
                "__value": "digital,Tb"
            },
            {
                "value": "Pb",
                "label": "Pb",
                "__label": "数据大小 / Pb",
                "__value": "digital,Pb"
            },
            {
                "value": "Eb",
                "label": "Eb",
                "__label": "数据大小 / Eb",
                "__value": "digital,Eb"
            },
            {
                "value": "Zb",
                "label": "Zb",
                "__label": "数据大小 / Zb",
                "__value": "digital,Zb"
            },
            {
                "value": "Yb",
                "label": "Yb",
                "__label": "数据大小 / Yb",
                "__value": "digital,Yb"
            },
            {
                "value": "B",
                "label": "B",
                "__label": "数据大小 / B",
                "__value": "digital,B"
            },
            {
                "value": "KB",
                "label": "KB",
                "__label": "数据大小 / KB",
                "__value": "digital,KB"
            },
            {
                "value": "MB",
                "label": "MB",
                "__label": "数据大小 / MB",
                "__value": "digital,MB"
            },
            {
                "value": "GB",
                "label": "GB",
                "__label": "数据大小 / GB",
                "__value": "digital,GB"
            },
            {
                "value": "TB",
                "label": "TB",
                "__label": "数据大小 / TB",
                "__value": "digital,TB"
            },
            {
                "value": "PB",
                "label": "PB",
                "__label": "数据大小 / PB",
                "__value": "digital,PB"
            },
            {
                "value": "EB",
                "label": "EB",
                "__label": "数据大小 / EB",
                "__value": "digital,EB"
            },
            {
                "value": "ZB",
                "label": "ZB",
                "__label": "数据大小 / ZB",
                "__value": "digital,ZB"
            },
            {
                "value": "YB",
                "label": "YB",
                "__label": "数据大小 / YB",
                "__value": "digital,YB"
            }
        ]
    },
    {
        "value": "time",
        "label": "时间间隔",
        "children": [
            {
                "value": "ns",
                "label": "ns",
                "__label": "时间间隔 / ns",
                "__value": "time,ns"
            },
            {
                "value": "μs",
                "label": "μs",
                "__label": "时间间隔 / μs",
                "__value": "time,μs"
            },
            {
                "value": "ms",
                "label": "ms",
                "__label": "时间间隔 / ms",
                "__value": "time,ms"
            },
            {
                "value": "s",
                "label": "s",
                "__label": "时间间隔 / s",
                "__value": "time,s"
            },
            {
                "value": "min",
                "label": "min",
                "__label": "时间间隔 / min",
                "__value": "time,min"
            },
            {
                "value": "h",
                "label": "h",
                "__label": "时间间隔 / h",
                "__value": "time,h"
            },
            {
                "value": "d",
                "label": "d",
                "__label": "时间间隔 / d",
                "__value": "time,d"
            },
            {
                "value": "week",
                "label": "week",
                "__label": "时间间隔 / week",
                "__value": "time,week"
            },
            {
                "value": "month",
                "label": "month",
                "__label": "时间间隔 / month",
                "__value": "time,month"
            },
            {
                "value": "year",
                "label": "year",
                "__label": "时间间隔 / year",
                "__value": "time,year"
            }
        ]
    },
    {
        "label": "时间戳",
        "value": "timeStamp",
        "children": [
            {
                "label": "s",
                "value": "s",
                "__label": "时间戳 / s",
                "__value": "timeStamp,s"
            },
            {
                "label": "ms",
                "value": "ms",
                "__label": "时间戳 / ms",
                "__value": "timeStamp,ms"
            },
            {
                "label": "μs",
                "value": "μs",
                "__label": "时间戳 / μs",
                "__value": "timeStamp,μs"
            },
            {
                "label": "ns",
                "value": "ns",
                "__label": "时间戳 / ns",
                "__value": "timeStamp,ns"
            }
        ]
    },
    {
        "label": "流量",
        "value": "traffic",
        "children": [
            {
                "label": "B/S",
                "value": "B/S",
                "__label": "流量 / B/S",
                "__value": "traffic,B/S"
            },
            {
                "label": "KB/S",
                "value": "KB/S",
                "__label": "流量 / KB/S",
                "__value": "traffic,KB/S"
            },
            {
                "label": "MB/S",
                "value": "MB/S",
                "__label": "流量 / MB/S",
                "__value": "traffic,MB/S"
            },
            {
                "label": "GB/S",
                "value": "GB/S",
                "__label": "流量 / GB/S",
                "__value": "traffic,GB/S"
            },
            {
                "label": "TB/S",
                "value": "TB/S",
                "__label": "流量 / TB/S",
                "__value": "traffic,TB/S"
            }
        ]
    },
    {
        "label": "带宽",
        "value": "bandWidth",
        "children": [
            {
                "label": "bps",
                "value": "bps",
                "__label": "带宽 / bps",
                "__value": "bandWidth,bps"
            },
            {
                "label": "Kbps",
                "value": "Kbps",
                "__label": "带宽 / Kbps",
                "__value": "bandWidth,Kbps"
            },
            {
                "label": "Mbps",
                "value": "Mbps",
                "__label": "带宽 / Mbps",
                "__value": "bandWidth,Mbps"
            },
            {
                "label": "Gbps",
                "value": "Gbps",
                "__label": "带宽 / Gbps",
                "__value": "bandWidth,Gbps"
            },
            {
                "label": "Tbps",
                "value": "Tbps",
                "__label": "带宽 / Tbps",
                "__value": "bandWidth,Tbps"
            }
        ]
    },
    {
        "value": "percent",
        "label": "百分比",
        "children": [
            {
                "value": "percent",
                "label": "0 - 100",
                "__label": "百分比 / 0 - 100",
                "__value": "percent,percent"
            },
            {
                "value": "percent_decimal",
                "label": "0.0 - 1.0",
                "__label": "百分比 / 0.0 - 1.0",
                "__value": "percent,percent_decimal"
            }
        ]
    },
    {
        "value": "rmb",
        "label": "人民币",
        "children": [
            {
                "value": "yuan",
                "label": "元",
                "__label": "人民币 / 元",
                "__value": "rmb,yuan"
            },
            {
                "value": "wan_yuan",
                "label": "万",
                "__label": "人民币 / 万",
                "__value": "rmb,wan_yuan"
            },
            {
                "value": "yi_yuan",
                "label": "亿",
                "__label": "人民币 / 亿",
                "__value": "rmb,yi_yuan"
            }
        ]
    },
    {
        "value": "currencySymbol",
        "label": "货币",
        "children": [
            {
                "value": "cny",
                "label": "人民币 (¥)",
                "__label": "货币 / 人民币 (¥)",
                "__value": "currencySymbol,cny"
            },
            {
                "value": "usd",
                "label": "美元 ($)",
                "__label": "货币 / 美元 ($)",
                "__value": "currencySymbol,usd"
            },
            {
                "value": "eur",
                "label": "欧元 (€)",
                "__label": "货币 / 欧元 (€)",
                "__value": "currencySymbol,eur"
            },
            {
                "value": "gbp",
                "label": "英镑 (£)",
                "__label": "货币 / 英镑 (£)",
                "__value": "currencySymbol,gbp"
            },
            {
                "value": "rub",
                "label": "卢布 (₽)",
                "__label": "货币 / 卢布 (₽)",
                "__value": "currencySymbol,rub"
            }
        ]
    },
    {
        "value": "frequency",
        "label": "频率",
        "children": [
            {
                "value": "mHz",
                "label": "mHz",
                "__label": "频率 / mHz",
                "__value": "frequency,mHz"
            },
            {
                "value": "Hz",
                "label": "Hz",
                "__label": "频率 / Hz",
                "__value": "frequency,Hz"
            },
            {
                "value": "kHz",
                "label": "kHz",
                "__label": "频率 / kHz",
                "__value": "frequency,kHz"
            },
            {
                "value": "MHz",
                "label": "MHz",
                "__label": "频率 / MHz",
                "__value": "frequency,MHz"
            },
            {
                "value": "GHz",
                "label": "GHz",
                "__label": "频率 / GHz",
                "__value": "frequency,GHz"
            },
            {
                "value": "THz",
                "label": "THz",
                "__label": "频率 / THz",
                "__value": "frequency,THz"
            },
            {
                "value": "rpm",
                "label": "rpm",
                "__label": "频率 / rpm",
                "__value": "frequency,rpm"
            },
            {
                "value": "deg/s",
                "label": "deg/s",
                "__label": "频率 / deg/s",
                "__value": "frequency,deg/s"
            },
            {
                "value": "rad/s",
                "label": "rad/s",
                "__label": "频率 / rad/s",
                "__value": "frequency,rad/s"
            }
        ]
    },
    {
        "value": "length",
        "label": "长度",
        "children": [
            {
                "value": "mm",
                "label": "mm",
                "__label": "长度 / mm",
                "__value": "length,mm"
            },
            {
                "value": "cm",
                "label": "cm",
                "__label": "长度 / cm",
                "__value": "length,cm"
            },
            {
                "value": "m",
                "label": "m",
                "__label": "长度 / m",
                "__value": "length,m"
            },
            {
                "value": "km",
                "label": "km",
                "__label": "长度 / km",
                "__value": "length,km"
            },
            {
                "value": "in",
                "label": "in",
                "__label": "长度 / in",
                "__value": "length,in"
            },
            {
                "value": "yd",
                "label": "yd",
                "__label": "长度 / yd",
                "__value": "length,yd"
            },
            {
                "value": "ft-us",
                "label": "ft-us",
                "__label": "长度 / ft-us",
                "__value": "length,ft-us"
            },
            {
                "value": "ft",
                "label": "ft",
                "__label": "长度 / ft",
                "__value": "length,ft"
            },
            {
                "value": "mi",
                "label": "mi",
                "__label": "长度 / mi",
                "__value": "length,mi"
            }
        ]
    },
    {
        "value": "angle",
        "label": "角度",
        "children": [
            {
                "value": "rad",
                "label": "rad",
                "__label": "角度 / rad",
                "__value": "angle,rad"
            },
            {
                "value": "deg",
                "label": "deg",
                "__label": "角度 / deg",
                "__value": "angle,deg"
            },
            {
                "value": "grad",
                "label": "grad",
                "__label": "角度 / grad",
                "__value": "angle,grad"
            },
            {
                "value": "arcmin",
                "label": "arcmin",
                "__label": "角度 / arcmin",
                "__value": "angle,arcmin"
            },
            {
                "value": "arcsec",
                "label": "arcsec",
                "__label": "角度 / arcsec",
                "__value": "angle,arcsec"
            }
        ]
    },
    {
        "value": "mass",
        "label": "重量",
        "children": [
            {
                "value": "mcg",
                "label": "mcg",
                "__label": "重量 / mcg",
                "__value": "mass,mcg"
            },
            {
                "value": "mg",
                "label": "mg",
                "__label": "重量 / mg",
                "__value": "mass,mg"
            },
            {
                "value": "g",
                "label": "g",
                "__label": "重量 / g",
                "__value": "mass,g"
            },
            {
                "value": "kg",
                "label": "kg",
                "__label": "重量 / kg",
                "__value": "mass,kg"
            },
            {
                "value": "mt",
                "label": "mt",
                "__label": "重量 / mt",
                "__value": "mass,mt"
            },
            {
                "value": "oz",
                "label": "oz",
                "__label": "重量 / oz",
                "__value": "mass,oz"
            },
            {
                "value": "lb",
                "label": "lb",
                "__label": "重量 / lb",
                "__value": "mass,lb"
            },
            {
                "value": "t",
                "label": "t",
                "__label": "重量 / t",
                "__value": "mass,t"
            }
        ]
    },
    {
        "label": "数值",
        "value": "number",
        "children": [
            {
                "label": "万进制",
                "value": "default",
                "__label": "数值 / 万进制",
                "__value": "number,default"
            },
            {
                "label": "短级差制",
                "value": "short_scale",
                "__label": "数值 / 短级差制",
                "__value": "number,short_scale"
            }
        ]
    },
    {
        "value": "speed",
        "label": "速度",
        "children": [
            {
                "value": "m/s",
                "label": "m/s",
                "__label": "速度 / m/s",
                "__value": "speed,m/s"
            },
            {
                "value": "km/h",
                "label": "km/h",
                "__label": "速度 / km/h",
                "__value": "speed,km/h"
            },
            {
                "value": "m/h",
                "label": "m/h",
                "__label": "速度 / m/h",
                "__value": "speed,m/h"
            },
            {
                "value": "knot",
                "label": "knot",
                "__label": "速度 / knot",
                "__value": "speed,knot"
            },
            {
                "value": "ft/s",
                "label": "ft/s",
                "__label": "速度 / ft/s",
                "__value": "speed,ft/s"
            }
        ]
    },
    {
        "value": "temperature",
        "label": "温度",
        "children": [
            {
                "value": "C",
                "label": "C",
                "__label": "温度 / C",
                "__value": "temperature,C"
            },
            {
                "value": "K",
                "label": "K",
                "__label": "温度 / K",
                "__value": "temperature,K"
            },
            {
                "value": "F",
                "label": "F",
                "__label": "温度 / F",
                "__value": "temperature,F"
            },
            {
                "value": "R",
                "label": "R",
                "__label": "温度 / R",
                "__value": "temperature,R"
            }
        ]
    },
    {
        "value": "throughput",
        "label": "吞吐量",
        "children": [
            {
                "value": "ops",
                "label": "ops",
                "__label": "吞吐量 / ops",
                "__value": "throughput,ops"
            },
            {
                "value": "reqps",
                "label": "reqps",
                "__label": "吞吐量 / reqps",
                "__value": "throughput,reqps"
            },
            {
                "value": "readps",
                "label": "readps",
                "__label": "吞吐量 / readps",
                "__value": "throughput,readps"
            },
            {
                "value": "wps",
                "label": "wps",
                "__label": "吞吐量 / wps",
                "__value": "throughput,wps"
            },
            {
                "value": "iops",
                "label": "iops",
                "__label": "吞吐量 / iops",
                "__value": "throughput,iops"
            },
            {
                "value": "opm",
                "label": "opm",
                "__label": "吞吐量 / opm",
                "__value": "throughput,opm"
            },
            {
                "value": "readpm",
                "label": "readpm",
                "__label": "吞吐量 / readpm",
                "__value": "throughput,readpm"
            },
            {
                "value": "wpm",
                "label": "wpm",
                "__label": "吞吐量 / wpm",
                "__value": "throughput,wpm"
            }
        ]
    },
    {
        "value": "custom",
        "label": "自定义",
        "__label": "自定义",
        "__value": "custom"
    }
]


```


