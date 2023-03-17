let api,
  lang = 'zh'
const PAGE_SIZE = 50
const SearchMessageType = {
  SETUP: 0 /* Search index setup */,
  READY: 1 /* Search index ready */,
  QUERY: 2 /* Search query */,
  RESULT: 3 /* Search results */,
}
function debounce(fn, delay, immediate) {
  let result,
    timeout = null
  return function debounced() {
    if (timeout) clearTimeout(timeout)
    const context = this
    const args = arguments
    timeout = setTimeout(function () {
      result = fn.apply(context, args)
      timeout = null
    }, delay)
    return result
  }
}
function request(q) {
  return new Promise(function (resolve, reject) {
    var oReq = new XMLHttpRequest()
    oReq.onreadystatechange = function () {
      if (this.readyState === XMLHttpRequest.DONE) {
        if (this.status === 200) {
          const response = JSON.parse(this.responseText)
          resolve((response && response.content && response.content.list) || [])
        } else {
          reject(this.responseText)
        }
      }
    }
    url = `${api}/api/v1/doc_search/search?language=${lang}&keyword=${q}&size=${PAGE_SIZE}`
    oReq.open('GET', url)
    oReq.setRequestHeader('Content-Type', 'application/json')
    oReq.send()
  })
}
async function requestPromise(query) {
  try {
    if (query && api) {
      query = query.replace(/\*$/g, '')
      const list = await request(query)
      let data = []

      if (list.length) {
        data = list.map(function (_item, index) {
          return [_item]
        })
      }
      return {
        type: SearchMessageType.RESULT,
        data: {
          items: data,
        },
      }
    } else {
      return {
        type: SearchMessageType.RESULT,
        data: {
          items: [],
        },
      }
    }
  } catch (err) {
    console.error(err)
    return {
      type: SearchMessageType.RESULT,
      data: {
        items: [],
      },
    }
  }
}

async function handler(message) {
  if (SearchMessageType.QUERY === message.type) {
    return await requestPromise(message.data)
  } else if (SearchMessageType.SETUP === message.type) {
    const config = message.data?.config
    if (config) {
      api = config.api
      lang = config.clang || 'zh'
    }
    return {
      type: SearchMessageType.READY,
    }
  } else {
  }
}
async function toPostMessage(ev) {
  postMessage(await handler(ev.data))
}
addEventListener('message', toPostMessage)
