
<link href="/assets/stylesheets/search.css" rel="stylesheet">

<div class="cu-search-result-layout" id="custom-search">
<script id="no-result-tmpl" type="text/template">
    <div class="no-result-text">没有找到符合条件的结果</div>
</script>
<script id="prev-btn-tmpl" type="text/template">
    <a id="btn-prev" class="btn">前一页</a>
</script>
<script id="next-btn-tmpl" type="text/template">
    <a id="btn-next" class="btn">后一页</a>
</script>
<script id="page-btn-tmpl" type="text/template">
    <a class="page-num btn"></a>
</script>
<script id="more-btn-tmpl" type="text/template">
    <a id="btn-more" class="btn ">...</a>
</script>
<script id="less-btn-tmpl" type="text/template">
    <a id="btn-less" class="btn ">...</a>
</script>
    <h1 class="pagetitle">搜索结果</h1>
    <div id="search-result-content" class="hide">
        <div id="search-result-count"><span></span> 条结果</div>
        <div id="search-list">
        </div>
    </div>
    <div id="search-page_navigation" class="search-page_navigation">
    </div>
</div>
<script src="/assets/javascripts/search.js" ></script>