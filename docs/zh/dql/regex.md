# 正则表达式模版库

## 海外信用卡

1. Visa 卡扫描(4x4位)：`\b4\d{3}(?:(?:,\d{4}){3}|(?:\s\d{4}){3}|(?:\.\d{4}){3}|(?:-\d{4}){3})\b`
2. Visa 卡扫描(2x8位)：`\b4\d{3}(?:(?:\d{4}(?:(?:,\d{8})|(?:-\d{8})|(?:\s\d{8})|(?:\.\d{8}))))\b`
3. Visa 卡扫描(1x16位和1x19位)：`\b4\d{15}(?:\d{3})?\b`
4. Master 卡扫描(4x4位)：`\b(?:(?:5[1-5]\d{2})|(?:222[1-9])|(?:22[3-9]\d)|(?:2[3-6]\d{2})|(?:27[0-1]\d)|(?:2720))(?:(?:\s\d{4}){3}|(?:\.\d{4}){3}|(?:-\d{4}){3}|(?:,\d{4}){3})\b`
5. Master 卡扫描(2x8位)：`\b(?:(?:5[1-5]\d{2})|(?:222[1-9])|(?:22[3-9]\d)|(?:2[3-6]\d{2})|(?:27[0-1]\d)|(?:2720))(?:(?:\d{4}(?:(?:,\d{8})|(?:-\d{8})|(?:\s\d{8})|(?:\.\d{8}))))\b`
6. Master 卡扫描(1x16位)：`\b(?:(?:5[1-5]\d{2})|(?:222[1-9])|(?:22[3-9]\d)|(?:2[3-6]\d{2})|(?:27[0-1]\d)|(?:2720))(?:\d{12})\b`
7. Discover 卡扫描(4x4位)：`\b(?:(?:(?:6221(?:2[6-9]|[3-9][0-9])\d{2}(?:,\d{4}){2})|(?:6221\s(?:2[6-9]|[3-9][0-9])\d{2}(?:\s\d{4}){2})|(?:6221\.(?:2[6-9]|[3-9][0-9])\d{2}(?:\.\d{4}){2})|(?:6221-(?:2[6-9]|[3-9][0-9])\d{2}(?:-\d{4}){2}))|(?:(?:6229(?:[01][0-9]|2[0-5])\d{2}(?:,\d{4}){2})|(?:6229\s(?:[01][0-9]|2[0-5])\d{2}(?:\s\d{4}){2})|(?:6229\.(?:[01][0-9]|2[0-5])\d{2}(?:\.\d{4}){2})|(?:6229-(?:[01][0-9]|2[0-5])\d{2}(?:-\d{4}){2}))|(?:(?:6011|65\d{2}|64[4-9]\d|622[2-8])(?:(?:\s\d{4}){3}|(?:\.\d{4}){3}|(?:-\d{4}){3}|(?:,\d{4}){3})))\b`
8. Discover 卡扫描(2x8位)：`\b(?:6221(?:2[6-9]|[3-9][0-9])\d{2}(?:,\d{8}|\s\d{8}|-\d{8}|\.\d{8})|6229(?:[01][0-9]|2[0-5])\d{2}(?:,\d{8}|\s\d{8}|-\d{8}|\.\d{8})|(?:6011|65\d{2}|64[4-9]\d|622[2-8])\d{4}(?:,\d{8}|\s\d{8}|-\d{8}|\.\d{8}))\b`
9. Discover 卡扫描(1x16位)：`\b(?:6221(?:2[6-9]|[3-9][0-9])\d{10}|6229(?:[01][0-9]|2[0-5])\d{10}|(?:6011|65\d{2}|64[4-9]\d|622[2-8])\d{12})\b`
10. 美国运通卡扫描(4+6+5位)：`\b3[47]\d{2}(?:(?:\s\d{6}\s\d{5})|(?:\.\d{6}\.\d{5})|(?:-\d{6}-\d{5})|(?:,\d{6},\d{5}))\b`
11. 美国运通卡扫描(4+4+4+3位)：`\b3[47]\d{2}(?:(?:\s\d{4}\s\d{4}\s\d{3})|(?:\,\d{4}\,\d{4}\,\d{3})|(?:-\d{4}-\d{4}-\d{3})|(?:\.\d{4}\.\d{4}\.\d{3}))\b`
12. 美国运通卡扫描(8+7位)：`\b3[47]\d{6}(?:(?:\s\d{7})|(?:\,\d{7})|(?:-\d{7})|(?:\.\d{7}))\b`
13. 美国运通卡扫描 (1x15位)：`\b3[47]\d{13}\b`
14. Diners 大莱卡扫描(4+6+4位)：`\b(?:30[0-59]\d|3[689]\d{2})(?:(?:\s\d{6}\s\d{4})|(?:\.\d{6}\.\d{4})|(?:-\d{6}-\d{4})|(?:,\d{6},\d{4}))\b`
15. Diners 大莱卡扫描(4+4+4+2位)：`\b(?:30[0-59]\d|3[689]\d{2})(?:(?:\s\d{4}\s\d{4}\s\d{2})|(?:\,\d{4}\,\d{4}\,\d{2})|(?:-\d{4}-\d{4}-\d{2})|(?:\.\d{4}\.\d{4}\.\d{2}))\b`
16. Diners 大莱卡扫描(8+6位)：`\b(?:30[0-59]\d{5}|3[689]\d{6})(?:(?:\s\d{6})|(?:\,\d{6})|(?:-\d{6})|(?:\.\d{6}))\b`
17. Diners 大莱卡扫描((1x14位)：`(?:30[0-59]\d|3[689]\d{2})(?:\d{10})`
18. JCB 卡扫描(4x4位)：`\b35(?:2[89]|[3-9][0-9])(?:(?:\s\d{4}){3}|(?:\.\d{4}){3}|(?:-\d{4}){3}|(?:,\d{4}){3})\b`
19. JCB 卡扫描(2x8位)：`\b35(?:2[89]|[3-9][0-9])\d{4}(?:(?:,\d{8})|(?:-\d{8})|(?:\s\d{8})|(?:\.\d{8}))\b`
20. JCB 卡扫描(1x16位)：`\b35(?:2[89]|[3-9][0-9])(?:\d{12})\b`
21. Maestro 万事达卡扫描(4x4位)：`\b(?:5[06-9]\d{2}|6\d{3})(?:(?:\s\d{4}){3}|(?:\.\d{4}){3}|(?:-\d{4}){3}|(?:,\d{4}){3})\b`
22. Maestro 万事达卡扫描(2x8位)：`\b(?:5[06-9]\d{6}|6\d{7})(?:\s\d{8}|\.\d{8}|-\d{8}|,\d{8})\b`
23. Maestro 万事达卡扫描(1x16位)：`\b(?:5[06-9]\d{2}|6\d{3})(?:\d{12})\b`
24. IBAN 国际银行帐户号码扫描：`\b(?:NO\d{2}(?:[ \-]?\d{4}){2}[ \-]?\d{3}|BE\d{2}(?:[ \-]?\d{4}){3}|(?:DK|FO|FI|GL|SD)\d{2}(?:[ \-]?\d{4}){3}[ \-]?\d{2}|NL\d{2}[ \-]?[A-Z]{4}(?:[ \-]?\d{4}){2}[ \-]?\d{2}|MK\d{2}[ \-]?\d{3}[A-Z0-9](?:[ \-]?[A-Z0-9]{4}){2}[ \-]?[A-Z0-9]\d{2}|SI\d{17}|(?:AT|BA|EE|LT|XK)\d{18}|(?:LU|KZ|EE|LT)\d{5}[A-Z0-9]{13}|LV\d{2}[A-Z]{4}[A-Z0-9]{13}|(?:LI|CH)\d{2}[ \-]?\d{4}[ \-]?\d[A-Z0-9]{3}(?:[ \-]?[A-Z0-9]{4}){2}[ \-]?[A-Z0-9]|HR\d{2}(?:[ \-]?\d{4}){4}[ \-]?\d|GE\d{2}[ \-]?[A-Z0-9]{2}\d{2}\d{14}|VA\d{20}|BG\d{2}[A-Z]{4}\d{6}[A-Z0-9]{8}|BH\d{2}[A-Z]{4}[A-Z0-9]{14}|GB\d{2}[A-Z]{4}(?:[ \-]?\d{4}){3}[ \-]?\d{2}|IE\d{2}[ \-]?[A-Z0-9]{4}(?:[ \-]?\d{4}){3}[ \-]?\d{2}|(?:CR|DE|ME|RS)\d{2}(?:[ \-]?\d{4}){4}[ \-]?\d{2}|(?:AE|TL|IL)\d{2}(?:[ \-]?\d{4}){4}[ \-]?\d{3}|GI\d{2}[ \-]?[A-Z]{4}(?:[ \-]?[A-Z0-9]{4}){3}[ \-]?[A-Z0-9]{3}|IQ\d{2}[ \-]?[A-Z]{4}(?:[ \-]?\d{4}){3}[ \-]?\d{3}|MD\d{2}(?:[ \-]?[A-Z0-9]{4}){5}|SA\d{2}[ \-]?\d{2}[A-Z0-9]{2}(?:[ \-]?[A-Z0-9]{4}){4}|RO\d{2}[ \-]?[A-Z]{4}(?:[ \-]?[A-Z0-9]{4}){4}|(?:PK|VG)\d{2}[ \-]?[A-Z0-9]{4}(?:[ \-]?\d{4}){4}|AD\d{2}(?:[ \-]?\d{4}){2}(?:[ \-]?[A-Z0-9]{4}){3}|(?:CZ|SK|ES|SE|TN)\d{2}(?:[ \-]?\d{4}){5}|(?:LY|PT|ST)\d{2}(?:[ \-]?\d{4}){5}[ \-]?\d|TR\d{2}[ \-]?\d{4}[ \-]?\d[A-Z0-9]{3}(?:[ \-]?[A-Z0-9]{4}){3}[ \-]?[A-Z0-9]{2}|IS\d{2}(?:[ \-]?\d{4}){5}[ \-]?\d{2}|(?:IT|SM)\d{2}[ \-]?[A-Z]\d{3}[ \-]?\d{4}[ \-]?\d{3}[A-Z0-9](?:[ \-]?[A-Z0-9]{4}){2}[ \-]?[A-Z0-9]{3}|GR\d{2}[ \-]?\d{4}[ \-]?\d{3}[A-Z0-9](?:[ \-]?[A-Z0-9]{4}){3}[A-Z0-9]{3}|(?:FR|MC)\d{2}(?:[ \-]?\d{4}){2}[ \-]?\d{2}[A-Z0-9]{2}(?:[ \-]?[A-Z0-9]{4}){2}[ \-]?[A-Z0-9]\d{2}|MR\d{2}(?:[ \-]?\d{4}){5}[ \-]?\d{3}|(?:SV|DO)\d{2}[ \-]?[A-Z]{4}(?:[ \-]?\d{4}){5}|BY\d{2}[ \-]?[A-Z]{4}[ \-]?\d{4}(?:[ \-]?[A-Z0-9]{4}){4}|GT\d{2}(?:[ \-]?[A-Z0-9]{4}){6}|AZ\d{2}[ \-]?[A-Z0-9]{4}(?:[ \-]?\d{5}){4}|LB\d{2}[ \-]?\d{4}(?:[ \-]?[A-Z0-9]{5}){4}|(?:AL|CY)\d{2}(?:[ \-]?\d{4}){2}(?:[ \-]?[A-Z0-9]{4}){4}|(?:HU|PL)\d{2}(?:[ \-]?\d{4}){6}|QA\d{2}[ \-]?[A-Z]{4}(?:[ \-]?[A-Z0-9]{4}){5}[ \-]?[A-Z0-9]|PS\d{2}[ \-]?[A-Z0-9]{4}(?:[ \-]?\d{4}){5}[ \-]?\d|UA\d{2}[ \-]?\d{4}[ \-]?\d{2}[A-Z0-9]{2}(?:[ \-]?[A-Z0-9]{4}){4}[ \-]?[A-Z0-9]|BR\d{2}(?:[ \-]?\d{4}){5}[ \-]?\d{3}[A-Z0-9][ \-]?[A-Z0-9]|EG\d{2}(?:[ \-]?\d{4}){6}\d|MU\d{2}[ \-]?[A-Z]{4}(?:[ \-]?\d{4}){4}\d{3}[A-Z][ \-]?[A-Z]{2}|(?:KW|JO)\d{2}[ \-]?[A-Z]{4}(?:[ \-]?[A-Z0-9]{4}){5}[ \-]?[A-Z0-9]{2}|MT\d{2}[ \-]?[A-Z]{4}[ \-]?\d{4}[ \-]?\d[A-Z0-9]{3}(?:[ \-]?[A-Z0-9]{3}){4}[ \-]?[A-Z0-9]{3}|SC\d{2}[ \-]?[A-Z]{4}(?:[ \-]?\d{4}){5}[ \-]?[A-Z]{3}|LC\d{2}[ \-]?[A-Z]{4}(?:[ \-]?[A-Z0-9]{4}){6})\b`

## 网络和设备信息

1. IPv4 地址扫描：`\b((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])\b`
2. IPv6 地址扫描：`(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))`
3. 标准的 Mac 地址扫描：`\b(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})\b`
4. HTTP Basic Authentification Header 扫描：`\bAuthorization:\s+Basic\s+[A-Za-z0-9+/=]+\b`
5. HTTP Cookie 扫描：`\bSet-Cookie:\s*(?:[^;,]+)(?:;\s*(?:[^,]+))*\b`
6. HTTP(S) URL 扫描：`https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)`

## 个人敏感信息

1. 标准邮箱地址扫描：\b[\w!#$%&'*+\/=?`{|}~^-]+(?:\.[\w!#$%&'*+\/=?`{|}~^-]+)*(%40|@)(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}\b
2. 美国护照扫描：`(?i)\b(?:passport)(?:_\w+)?\W{0,30}(?:\b[0-9A-Z]{9}\b|\b[0-9]{6}[A-Z][0-9]{2}\b)`
3. 美国车辆识别码扫描：`(?i)\b(?:vehicle[_\s-]*identification[_\s-]*number|vin)\W{0,30}\b[A-HJ-NPR-Z0-9]{17}\b`
4. 英国社保号扫描：`(?i)\b(?:national[\s_]?(?:insurance(?:\s+number)?)?|NIN|NI[\s_]?number|insurance[\s_]?number)\b(?:\W{0,30})?\b[A-Z]{2}\d{6}[A-Z]?\b`
5. 加拿大社保号扫描：`(?i)\b(?:social[\s_]?(?:insurance(?:\s+number)?)?|SIN|Canadian[\s_]?(?:social[\s_]?(?:insurance)?|insurance[\s_]?number)?)\b(?:\W{0,30})?\b\d{3}-\d{3}-\d{3}\b`

## 密钥和凭证

1. AWS Access Key ID 扫描：`(AKIA|A3T|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[0-9A-Z]{16}`
2. AWS Secret Access Key 扫描：`(aws|AWS|amazon).{0,19}\b[A-Za-z0-9/+]{40}\b`
3. Dynatrace Token 扫描：`dt0[a-zA-Z]{1}[0-9]{2}\.[A-Z0-9]{24}\.[A-Z0-9]{64}`
4. Facebook accessToken 扫描：`EAACEdEose0cBA[0-9A-Za-z]+`
5. Gitlab Token 扫描：`glpat-[\w\\-]{20}`
6. Instagram Token 扫描：`(?i)\b(igqvj|instagram).*?[a-z0-9]{100,250}\b`
7. JSON Web Token 扫描：`\bey[I-L][\w=-]+\.ey[I-L][\w=-]+(\.[\w.+/=-]+)?\b`
8. Mailchimp API Key 扫描：`[0-9a-f]{32}-us[0-9]{1,2}`
9. Mailgun API Key 扫描：`key-[0-9a-zA-Z]{32}`
10. Okta API Token 扫描：`SSWS 00[a-zA-Z0-9\-\_]{40}`
11. Slack Access Token 扫描：`xox[baprs]-([0-9a-zA-Z]{10,48})?`
12. Stripe API Key 扫描：`sk_live_[0-9a-zA-Z]{24}`
13. Stripe Restricted API Key 扫描：`rk_live_[0-9a-zA-Z]{24}`
14. Twilio API Key 扫描：`\bSK[0-9a-fA-F]{32}\b`
15. Square Access Token 扫描：`sq0atp-[0-9A-Za-z\-_]{22}`
16. Square OAuth Secret 扫描：`sq0csp-[0-9A-Za-z\-_]{43}`
17. Google API Key 扫描：`\bAIza[0-9A-Za-z\\-_]{35}\b`
18. Google OAuth Access Token 扫描：`\bya29\.[0-9A-Za-z\\-_]+\b`
19. RSA Private Key 扫描：`BEGIN RSA PRIVATE KEY`
20. Send Grid API Token 扫描：`SG\.[a-zA-Z0-9]{22}\.[a-zA-Z0-9]{43}`
21. Heroku API Key 扫描：`[h|H][e|E][r|R][o|O][k|K][u|U].{0,29}[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}`
22. SSH Key 扫描：`BEGIN OPENSSH PRIVATE KEY|BEGIN SSH PRIVATE KEY|BEGIN DSA PRIVATE KEY|BEGIN EC PRIVATE KEY`
23. PGP Private Key 扫描：`BEGIN PGP PRIVATE KEY BLOCK`
24. Paypal Braintree Access Token 扫描：`access_token\$production\$[0-9a-z]{16}\$[0-9a-f]{32}`
25. Amazon Marketplace Web Services Auth Token 扫描：`amzn\.mws\.[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b`
26. Azure Personal Access Token 扫描：`((?i)azure)[\s\S]{0,16}[a-z0-9]{52}\b`
27. Azure SQL Connection String 扫描：`(?i)[a-z][a-z0-9-]+\.database(?:\.secure)?\.(?:(?:windows|usgovcloudapi)\.net|chinacloudapi\.cn|cloudapi\.de)`
28. Azure Subscription Key 扫描：`((?i)(subscription|authoring|programmatic))[\s\S]{0,30}[\W][a-z0-9]{32}\b`
29. Bearer Token 扫描：`(?i)bearer [-a-z0-9._~+/]{4,}`
30. Checkout.com Secret 扫描：`\bsk_((sbox_)?[a-z0-9]{27}|(test_)?[a-fA-F0-9]{8}-([a-fA-F0-9]{4}-){3}[a-fA-F0-9]{12})\b`
31. Databricks Personal Access Token 扫描：`\bdapi[a-h0-9]{32}\b`
32. Docker Swarm Join Token 扫描：`\bSWMTKN-1-[\w\d-]{76}\b`
33. Docker Swarm Unlock Key 扫描：`\bSWMKEY-1-[\w\d+/]{43}\b`
34. Github Access Token 扫描：`\bgh[opsu]_[0-9a-zA-Z]{36}\b`
35. Github Refresh Token 扫描：`\bghr_[0-9a-zA-Z]{76}\b`
36. JIRA API Token 扫描：`(jira|JIRA|Jira).{0,24}[a-zA-Z0-9]{20}[A-Z0-9]{4}\b`
37. LinkedIn Secret 扫描：`(?i)linkedin(.{0,20})?[:='"][0-9a-z]{16}\b`
38. Shopify Access Token 扫描：`\bshp(at|ca|pa)_[a-fA-F0-9]{32}\b`
39. Shopify Shared Secret 扫描：`\bshpss_[a-fA-F0-9]{32}\b`
40. Slack Webhook Secret 扫描：`\bT[a-zA-Z0-9_]{8}/B[a-zA-Z0-9_]{8}/[a-zA-Z0-9_]{24}\b`
41. Twitter Secret 扫描：`(?i)twitter(.{0,20})?[:='"][0-9a-z]{35,}\b`