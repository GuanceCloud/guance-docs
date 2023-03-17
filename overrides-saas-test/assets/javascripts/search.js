function getSearchTermFromLocation(query = 's') {
  var sPageURL = window.location.search.substring(1)
  var sURLVariables = sPageURL.split('&')
  for (var i = 0; i < sURLVariables.length; i++) {
    var sParameterName = sURLVariables[i].split('=')
    if (sParameterName[0] === query) {
      return decodeURIComponent(sParameterName[1].replace(/\+/g, '%20'))
    }
  }
}
const searchEl = document.getElementById('custom-search')
const totalEl = searchEl.querySelector('#search-result-count')
const searchListEl = searchEl.querySelector('#search-list')
const notResultTmpl = searchEl.querySelector('#no-result-tmpl')
const searchPageNavigationEl = searchEl.querySelector('#search-page_navigation')
const prevPageTmpl = searchEl.querySelector('#prev-btn-tmpl')
const nextPageTmpl = searchEl.querySelector('#next-btn-tmpl')
const pageBtnTmpl = searchEl.querySelector('#page-btn-tmpl')
const baseUrl = `${new URL(__search_config.base, new URL(location.href))}`
const DEFAULT_PAGE_SIZE = 20
let page = 1,
  pageSize = DEFAULT_PAGE_SIZE
q = ''
async function request() {
  return new Promise((resolve, reject) => {
    var oReq = new XMLHttpRequest()
    oReq.onreadystatechange = function () {
      if (this.readyState === XMLHttpRequest.DONE) {
        if (this.status === 200) {
          const response = JSON.parse(this.responseText)
          resolve(response && response.content)
        } else {
          reject(this.responseText)
        }
      }
    }
    url = `${__search_config.search.api}/api/v1/doc_search/search?language=${__search_config.search.lang}&keyword=${q}&page=${page}&size=${pageSize}`
    oReq.open('GET', url)
    oReq.setRequestHeader('Content-Type', 'application/json')
    oReq.send()
  })
}
function renderRow(rowData) {
  const row = document.createElement('div')
  row.setAttribute('class', 'search-list-row')
  const title = document.createElement('div')
  title.setAttribute('class', 'search-list-row-title')
  const titleA = document.createElement('a')
  titleA.setAttribute('href', `${new URL(rowData.location, baseUrl)}`)
  titleA.innerHTML = rowData.title
  title.append(titleA)
  const text = document.createElement('div')
  text.setAttribute('class', 'search-list-row-text')
  text.innerHTML = rowData.text.join('')
  row.appendChild(title)
  row.appendChild(text)
  return row
}
function createElement(str) {
  str = str.replace(/(\n|\r)/g, '').trim()
  var div = document.createElement('div')
  div.innerHTML = str
  return div.childNodes
}
const renderPageNav = function (total = 0) {
  if (total === 0) return
  const totalPage = Math.ceil(total / pageSize)
  const hasPrev = page > 1
  const hasNext = page < totalPage

  const prevNode = createElement(prevPageTmpl.innerHTML)[0]
  const nextNode = createElement(nextPageTmpl.innerHTML)[0]
  const pageParentEl = document.createElement('div')
  if (!hasPrev) {
    prevNode.classList.add('disabled')
  } else {
    prevNode.classList.remove('disabled')
  }
  pageParentEl.appendChild(prevNode)
  if (!hasNext) {
    nextNode.classList.add('disabled')
  } else {
    nextNode.classList.remove('disabled')
  }
  //   prevNode.onclick = function () {
  //     if (hasPrev) {
  //       page--
  //       gotoPage(page)
  //     }
  //   }
  //   nextNode.onclick = function () {
  //     if (hasNext) {
  //       page++
  //       gotoPage(page)
  //     }
  //   }
  let index = 1
  while (index <= totalPage) {
    const pageBtnNode = createElement(pageBtnTmpl.innerHTML)[0]
    pageBtnNode.innerHTML = index
    if (page === index) {
      pageBtnNode.classList.add('active')
    } else {
      pageBtnNode.classList.remove('active')
    }
    pageBtnNode.setAttribute('data-page', index)
    // pageBtnNode.onclick = function () {
    //   gotoPage(index)
    // }
    pageParentEl.appendChild(pageBtnNode)
    index++
  }
  pageParentEl.appendChild(nextNode)
  searchPageNavigationEl.innerHTML = pageParentEl.innerHTML
}
async function render() {
  if (!searchEl) return
  const result = await request()
  if (result) {
    totalEl.querySelector('span').innerText = result.total
    if (result.list.length) {
      const listContainer = document.createElement('div')
      result.list.forEach((item) => {
        const row = renderRow(item)
        listContainer.appendChild(row)
      })
      searchListEl.innerHTML = listContainer.innerHTML
      renderPageNav(result.total)
    } else {
      searchListEl.innerHTML = notResultTmpl.innerHTML
    }
  }
}
const initListener = function () {
  searchPageNavigationEl.addEventListener('click', function (evt) {
    const target = evt.target
    if (target && target.getAttribute('id') === 'btn-prev') {
      gotoPage(page - 1)
    } else if (target && target.getAttribute('id') === 'btn-next') {
      gotoPage(page + 1)
    } else if (target && target.getAttribute('class') && target.getAttribute('class').includes('page-num')) {
      const index = target.getAttribute('data-page')
      gotoPage(index)
    }
  })
}
const gotoPage = function (currentPage) {
  if (page === currentPage) return
  page = currentPage
  replaceLocation(true)
}
const replaceLocation = function (isReload = false) {
  const url = new URL(location.href)
  url.searchParams.set('s', q)
  url.searchParams.set('page', page)
  url.searchParams.set('size', pageSize)
  if (isReload) {
    location.href = url
  } else {
    history.replaceState({}, '', `${url}`)
  }
}
const init = function () {
  q = getSearchTermFromLocation()
  page = Number(getSearchTermFromLocation('page') || 1)
  pageSize = Number(getSearchTermFromLocation('size') || DEFAULT_PAGE_SIZE)
  replaceLocation()
  if (q) {
    render()
    initListener()
  }
}
init()
