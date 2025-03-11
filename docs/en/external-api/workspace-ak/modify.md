# Modify the Name of a Specified API Key

---

<br />**POST /api/v1/workspace/accesskey/{ak_uuid}/modify**

## Overview

## Route Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:---------|:--------------------------|
| ak_uuid       | string | Y        | UUID of the API Key       |

## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:-----------------------------------------------------------------------------|
| name          | string | Y        | Name information for the API Key<br>Example: xxx <br>Allow empty: False <br>Maximum length: 256 |

## Additional Parameter Notes

## Response
```shell
 
```