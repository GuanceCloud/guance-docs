---
icon: zy/integrations
---

# 集成

---


<!-- markdownlint-disable MD046 MD037 MD009 MD010 -->
<html lang="en">
  <div>
  	<style>
  		* {
  			box-sizing: border-box;
  		}
  		.integration-doc-container {
  			/* width: 720px; */
  			/* border: 1px solid #ccc; */
  			font-size: 12px;
  			/* border-style: none; */
  		}
  		.fth-integration-list-header {
  			margin-bottom: 8px;
            position: relative;
  		}
        .fth-integration-list-header img {
            height: 14px;
            width: 14px;
            position: absolute;
            top: 7px;
            left: 8px;
            border: 0;
        }
  		.fth-integration-list-header .integration-search-input {
  			border: 1px solid #ccc;
  			padding: 2px 10px 2px 26px;
  			width: 100%;
  			height: 30px;
  		}
  		.fth-integration-list-header .integration-tags-group {
  			margin: 12px 0;
  			display: flex;
  			grid-gap: 10px;
				flex-wrap: wrap;
  		}
  		.fth-integration-list-header .integration-tags-group .integration-tags-group-item {
  			line-height: 12px;
  			border-radius: 2px;
  			padding: 8px 10px;
  			cursor: pointer;
  			background-color: #f4f5f6;
  			color: #222;
  		}
  		.fth-integration-list-header .integration-tags-group .integration-tags-group-item.tag-active {
  			background-color: #e9effe;
  			color: #2f61cc;
  		}
  		.fth-integration-list-header .integration-tags-group .integration-tags-group-item:hover {
  			background-color: #e9effe;
  		}
  		.fth-integration-list-content {
  			display: grid;
  			grid-template-columns: repeat(auto-fill, minmax(284px, 1fr));
  			grid-gap: 14px;
  			-webkit-box-pack: center;
  			-ms-flex-pack: center;
  			justify-content: center;
  		}
  		.fth-integration-list-content .fth-integration-list-item {
  			border: 1px solid #e1e4e8;
  		}
  		.fth-integration-list-content .fth-integration-list-item:hover .fth-integration-list-card {
  			box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.07);
  			-webkit-box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.07);
  		}
  		.fth-integration-list-content .fth-integration-list-item .fth-integration-list-card {
  			cursor: pointer;
  			height: 72px;
  			border-radius: 2px;
  			position: relative;
  			display: flex;
  			justify-content: space-between;
  			align-items: center;
  			padding-left: 20px;
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-left {
  			flex: 1;
  			display: flex;
  			align-items: center;
            position: relative;
  		}
        .fth-integration-list-content .fth-integration-list-item .integration-list-item-left .glightbox {
           display: flex;
        }
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-left img {
  			width: 32px;
        min-width: 32px;
  			height: 32px;
  			border-style: none;
  		}
        .fth-integration-list-content .fth-integration-list-item .integration-list-item-left .fth-integration-mask-image {
            position: absolute;
            width: 32px;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 1;
            background-color: transparent;
        }
        .fth-integration-list-content .fth-integration-list-item .integration-list-item-left .fth-integration-description {
  			padding-right:10px
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-left .fth-integration-name {
  			font-size: 14px;
  			font-weight: 600;
  			line-height: 20px;
  			height: 20px;
  			display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            word-break: break-all;
  			margin-left: 10px;
  			color: #222;
  		}
         .fth-integration-list-content .fth-integration-list-item .integration-list-item-left .fth-integration-desc {
            margin-top:2px;
            color: #666;
            font-size: 12px;
            margin-left: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            max-height: 2.8em;
            line-height: 1.4em;
        }
  		.fth-integration-list-content .fth-integration-list-card:hover .integration-list-item-right {
  			display: inline-block;
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-right {
  			display: none;
  			flex: 0 0 34px;
  			height: 100%;
  			text-align: center;
  			line-height: 72px;
  			background: #f5f8ff;
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-right svg {
  			fill: #2f61cc;
  			height: 14px;
  			width: 14px;
  		}
  	</style>
  	<div class="integration-doc-container">
  		<div class="fth-integration-list-header">
  			<input placeholder="搜索集成" class="integration-search-input" type="text" />
            <img src="/assets/images/search.png" alt="">
  			<div class="integration-tags-group">
  				<!-- tags名称（数量） 内容前端根据dom计算自动生成 -->
  			</div>
  		</div>
  
  		<!-- 集成list -->
  		<div class="fth-integration-list-content">
            <div
  				class="fth-integration-list-item"
                style="display:none"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
                            src="../icon/integration-default-logo.png"
                            alt=""
  						/>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../active_directory"
  				data-tags=""
  				data-name="Active Directory"
  				data-summary="采集 Active Directory 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/active_directory/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Active Directory" class="fth-integration-name">Active Directory</div>
                            <div title="采集 Active Directory 相关指标信息" class="fth-integration-desc">采集 Active Directory 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aerospike"
  				data-tags=""
  				data-name="Aerospike"
  				data-summary="采集 Aerospike 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aerospike/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Aerospike" class="fth-integration-name">Aerospike</div>
                            <div title="采集 Aerospike 相关指标信息" class="fth-integration-desc">采集 Aerospike 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_analyticdb_postgresql"
  				data-tags="阿里云"
  				data-name="阿里云 AnalyticDB PostgreSQL"
  				data-summary="阿里云 AnalyticDB PostgreSQL 指标展示，包括cpu、内存、磁盘、协调节点、实例查询等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_analyticdb_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 AnalyticDB PostgreSQL" class="fth-integration-name">阿里云 AnalyticDB PostgreSQL</div>
                            <div title="阿里云 AnalyticDB PostgreSQL 指标展示，包括cpu、内存、磁盘、协调节点、实例查询等。" class="fth-integration-desc">阿里云 AnalyticDB PostgreSQL 指标展示，包括cpu、内存、磁盘、协调节点、实例查询等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_billing"
  				data-tags="阿里云"
  				data-name="阿里云 云账单"
  				data-summary="采集阿里云云账单信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_billing/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 云账单" class="fth-integration-name">阿里云 云账单</div>
                            <div title="采集阿里云云账单信息" class="fth-integration-desc">采集阿里云云账单信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_cdn"
  				data-tags="阿里云"
  				data-name="阿里云 CDN"
  				data-summary="阿里云 CDN 性能指标展示，包括每秒访问次数、下行流量、边缘带宽、响应时间、回源带宽、状态码等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_cdn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 CDN" class="fth-integration-name">阿里云 CDN</div>
                            <div title="阿里云 CDN 性能指标展示，包括每秒访问次数、下行流量、边缘带宽、响应时间、回源带宽、状态码等。" class="fth-integration-desc">阿里云 CDN 性能指标展示，包括每秒访问次数、下行流量、边缘带宽、响应时间、回源带宽、状态码等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_clickhouse_community"
  				data-tags="阿里云"
  				data-name="阿里云 ClickHouse 社区兼容版"
  				data-summary="阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_clickhouse_community/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 ClickHouse 社区兼容版" class="fth-integration-name">阿里云 ClickHouse 社区兼容版</div>
                            <div title="阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。" class="fth-integration-desc">阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_ecs"
  				data-tags="阿里云,主机"
  				data-name="阿里云 ECS"
  				data-summary="阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 ECS" class="fth-integration-name">阿里云 ECS</div>
                            <div title="阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。" class="fth-integration-desc">阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_edas"
  				data-tags="阿里云"
  				data-name="阿里云 EDAS"
  				data-summary="采集阿里云 EDAS 指标、链路数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_edas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 EDAS" class="fth-integration-name">阿里云 EDAS</div>
                            <div title="采集阿里云 EDAS 指标、链路数据" class="fth-integration-desc">采集阿里云 EDAS 指标、链路数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_eip"
  				data-tags="阿里云"
  				data-name="阿里云 EIP"
  				data-summary="阿里云 EIP 指标展示，包括网络带宽、网络数据包、限速丢包率、带宽利用率等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 EIP" class="fth-integration-name">阿里云 EIP</div>
                            <div title="阿里云 EIP 指标展示，包括网络带宽、网络数据包、限速丢包率、带宽利用率等。" class="fth-integration-desc">阿里云 EIP 指标展示，包括网络带宽、网络数据包、限速丢包率、带宽利用率等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_es"
  				data-tags="阿里云"
  				data-name="阿里云 ElasticSearch"
  				data-summary="阿里云 ElasticSearch 指标展示，包括集群状态、索引 QPS、 节点 CPU/内存/磁盘使用率等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 ElasticSearch" class="fth-integration-name">阿里云 ElasticSearch</div>
                            <div title="阿里云 ElasticSearch 指标展示，包括集群状态、索引 QPS、 节点 CPU/内存/磁盘使用率等。" class="fth-integration-desc">阿里云 ElasticSearch 指标展示，包括集群状态、索引 QPS、 节点 CPU/内存/磁盘使用率等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_kafka"
  				data-tags="阿里云"
  				data-name="阿里云 KafKa"
  				data-summary="阿里云 KafKa 包括实例磁盘使用率、实例何topic 消息生产量、消息生产次数、消息消费量、消息消费次数等，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的可靠性保证。 "
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 KafKa" class="fth-integration-name">阿里云 KafKa</div>
                            <div title="阿里云 KafKa 包括实例磁盘使用率、实例何topic 消息生产量、消息生产次数、消息消费量、消息消费次数等，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的可靠性保证。 " class="fth-integration-desc">阿里云 KafKa 包括实例磁盘使用率、实例何topic 消息生产量、消息生产次数、消息消费量、消息消费次数等，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的可靠性保证。 </div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_lindorm"
  				data-tags="阿里云"
  				data-name="阿里云 Lindorm"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_lindorm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 Lindorm" class="fth-integration-name">阿里云 Lindorm</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>。" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_mongodb"
  				data-tags="阿里云"
  				data-name="阿里云 MongoDB"
  				data-summary="阿里云 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 分片集群指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 单节点实例指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、每秒语句执行次数、请求数、连接数、网络流量、QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 MongoDB" class="fth-integration-name">阿里云 MongoDB</div>
                            <div title="阿里云 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 分片集群指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 单节点实例指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、每秒语句执行次数、请求数、连接数、网络流量、QPS 等。" class="fth-integration-desc">阿里云 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 分片集群指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。
阿里云 MongoDB 单节点实例指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、每秒语句执行次数、请求数、连接数、网络流量、QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_nat"
  				data-tags="阿里云"
  				data-name="阿里云 NAT"
  				data-summary="阿里云 NAT 指标展示，包括并发连接数、新建连接数、 VPC 流量、 VPC 数据包等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_nat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 NAT" class="fth-integration-name">阿里云 NAT</div>
                            <div title="阿里云 NAT 指标展示，包括并发连接数、新建连接数、 VPC 流量、 VPC 数据包等。" class="fth-integration-desc">阿里云 NAT 指标展示，包括并发连接数、新建连接数、 VPC 流量、 VPC 数据包等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_newbgp_ddos"
  				data-tags="阿里云"
  				data-name="阿里云 DDoS 新BGP高防"
  				data-summary="阿里云DDoS新BGP高防的展示指标包括攻击防护能力、清洗能力、响应时间和可靠性，这些指标反映了新BGP高防服务在应对大规模DDoS攻击时的性能表现和可信度。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_newbgp_ddos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 DDoS 新BGP高防" class="fth-integration-name">阿里云 DDoS 新BGP高防</div>
                            <div title="阿里云DDoS新BGP高防的展示指标包括攻击防护能力、清洗能力、响应时间和可靠性，这些指标反映了新BGP高防服务在应对大规模DDoS攻击时的性能表现和可信度。" class="fth-integration-desc">阿里云DDoS新BGP高防的展示指标包括攻击防护能力、清洗能力、响应时间和可靠性，这些指标反映了新BGP高防服务在应对大规模DDoS攻击时的性能表现和可信度。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_oss"
  				data-tags="阿里云"
  				data-name="阿里云 OSS"
  				data-summary="阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_oss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 OSS" class="fth-integration-name">阿里云 OSS</div>
                            <div title="阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。" class="fth-integration-desc">阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_polardb_1.0"
  				data-tags="阿里云"
  				data-name="阿里云 PolarDB 分布式1.0"
  				data-summary="阿里云 PolarDB 分布式1.0展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 PolarDB 分布式1.0" class="fth-integration-name">阿里云 PolarDB 分布式1.0</div>
                            <div title="阿里云 PolarDB 分布式1.0展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS。" class="fth-integration-desc">阿里云 PolarDB 分布式1.0展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_polardb_2.0"
  				data-tags="阿里云"
  				data-name="阿里云 PolarDB 分布式 2.0"
  				data-summary="阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括CPU利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 PolarDB 分布式 2.0" class="fth-integration-name">阿里云 PolarDB 分布式 2.0</div>
                            <div title="阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括CPU利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。" class="fth-integration-desc">阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括CPU利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_polardb_mysql"
  				data-tags="阿里云"
  				data-name="阿里云 PolarDB MySQL"
  				data-summary="阿里云 PolarDB MySQL 指标展示，包括 CPU 使用率、内存命中率、网络流量、连接数、QPS、 TPS、 只读节点延迟等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 PolarDB MySQL" class="fth-integration-name">阿里云 PolarDB MySQL</div>
                            <div title="阿里云 PolarDB MySQL 指标展示，包括 CPU 使用率、内存命中率、网络流量、连接数、QPS、 TPS、 只读节点延迟等。" class="fth-integration-desc">阿里云 PolarDB MySQL 指标展示，包括 CPU 使用率、内存命中率、网络流量、连接数、QPS、 TPS、 只读节点延迟等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_polardb_oracle"
  				data-tags="阿里云"
  				data-name="阿里云 PolarDB Oracle"
  				data-summary="阿里云 PolarDB Oracle 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、IOPS、 TPS、 数据盘大小等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 PolarDB Oracle" class="fth-integration-name">阿里云 PolarDB Oracle</div>
                            <div title="阿里云 PolarDB Oracle 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、IOPS、 TPS、 数据盘大小等。" class="fth-integration-desc">阿里云 PolarDB Oracle 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、IOPS、 TPS、 数据盘大小等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_polardb_postgresql"
  				data-tags="阿里云"
  				data-name="阿里云 PolarDB PostgreSQL"
  				data-summary="阿里云 PolarDB PostgreSQL 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、 IOPS、 TPS、 数据盘大小等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 PolarDB PostgreSQL" class="fth-integration-name">阿里云 PolarDB PostgreSQL</div>
                            <div title="阿里云 PolarDB PostgreSQL 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、 IOPS、 TPS、 数据盘大小等。" class="fth-integration-desc">阿里云 PolarDB PostgreSQL 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、 IOPS、 TPS、 数据盘大小等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rds_mariadb"
  				data-tags="阿里云"
  				data-name="阿里云 RDS MariaDB"
  				data-summary="阿里云 RDS MariaDB 的展示指标包括响应时间、并发连接数、QPS 和 TPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RDS MariaDB" class="fth-integration-name">阿里云 RDS MariaDB</div>
                            <div title="阿里云 RDS MariaDB 的展示指标包括响应时间、并发连接数、QPS 和 TPS 等。" class="fth-integration-desc">阿里云 RDS MariaDB 的展示指标包括响应时间、并发连接数、QPS 和 TPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rds_mysql"
  				data-tags="阿里云"
  				data-name="阿里云 RDS MySQL"
  				data-summary="阿里云 RDS MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RDS MySQL" class="fth-integration-name">阿里云 RDS MySQL</div>
                            <div title="阿里云 RDS MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。" class="fth-integration-desc">阿里云 RDS MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rds_postgresql"
  				data-tags="阿里云"
  				data-name="阿里云 RDS PostgreSQL"
  				data-summary="阿里云 RDS PostgreSQL 指标展示，包括 CPU 使用率、内存使用率等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RDS PostgreSQL" class="fth-integration-name">阿里云 RDS PostgreSQL</div>
                            <div title="阿里云 RDS PostgreSQL 指标展示，包括 CPU 使用率、内存使用率等。" class="fth-integration-desc">阿里云 RDS PostgreSQL 指标展示，包括 CPU 使用率、内存使用率等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rds_sqlserver"
  				data-tags="阿里云"
  				data-name="阿里云 RDS SQLServer"
  				data-summary="阿里云 RDS SQLServer 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RDS SQLServer" class="fth-integration-name">阿里云 RDS SQLServer</div>
                            <div title="阿里云 RDS SQLServer 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。" class="fth-integration-desc">阿里云 RDS SQLServer 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_redis"
  				data-tags="阿里云"
  				data-name="阿里云 Redis 标准版"
  				data-summary="阿里云 Redis 标准版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 Redis 标准版" class="fth-integration-name">阿里云 Redis 标准版</div>
                            <div title="阿里云 Redis 标准版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。" class="fth-integration-desc">阿里云 Redis 标准版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_redis_shard"
  				data-tags="阿里云"
  				data-name="阿里云 Redis 集群版"
  				data-summary="阿里云 Redis 集群版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 Redis 集群版" class="fth-integration-name">阿里云 Redis 集群版</div>
                            <div title="阿里云 Redis 集群版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。" class="fth-integration-desc">阿里云 Redis 集群版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rocketmq4"
  				data-tags="阿里云"
  				data-name="阿里云 RocketMQ4"
  				data-summary="阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RocketMQ4" class="fth-integration-name">阿里云 RocketMQ4</div>
                            <div title="阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。" class="fth-integration-desc">阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_rocketmq5"
  				data-tags="阿里云"
  				data-name="阿里云 RocketMQ5"
  				data-summary="阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 RocketMQ5" class="fth-integration-name">阿里云 RocketMQ5</div>
                            <div title="阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。" class="fth-integration-desc">阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_sae"
  				data-tags="阿里云"
  				data-name="阿里云 SAE"
  				data-summary="采集阿里云 SAE（Serverless App Engine）的指标、日志、链路信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sae/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 SAE" class="fth-integration-name">阿里云 SAE</div>
                            <div title="采集阿里云 SAE（Serverless App Engine）的指标、日志、链路信息" class="fth-integration-desc">采集阿里云 SAE（Serverless App Engine）的指标、日志、链路信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_site"
  				data-tags="阿里云"
  				data-name="阿里云 站点监控"
  				data-summary="阿里云 站点监控主要获取站点拨测信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_site/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 站点监控" class="fth-integration-name">阿里云 站点监控</div>
                            <div title="阿里云 站点监控主要获取站点拨测信息" class="fth-integration-desc">阿里云 站点监控主要获取站点拨测信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_slb"
  				data-tags="阿里云"
  				data-name="阿里云 SLB"
  				data-summary="阿里云 SLB 指标展示，包括后端 ECS 实例状态、端口连接数、 QPS、网络流量、状态码等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_slb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 SLB" class="fth-integration-name">阿里云 SLB</div>
                            <div title="阿里云 SLB 指标展示，包括后端 ECS 实例状态、端口连接数、 QPS、网络流量、状态码等。" class="fth-integration-desc">阿里云 SLB 指标展示，包括后端 ECS 实例状态、端口连接数、 QPS、网络流量、状态码等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_sls"
  				data-tags="阿里云"
  				data-name="阿里云 SLS"
  				data-summary="阿里云 SLS 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sls/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 SLS" class="fth-integration-name">阿里云 SLS</div>
                            <div title="阿里云 SLS 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。" class="fth-integration-desc">阿里云 SLS 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aliyun_tair"
  				data-tags="阿里云"
  				data-name="阿里云 Tair 社区版"
  				data-summary="阿里云 Tair 社区版指标展示，包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_tair/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="阿里云 Tair 社区版" class="fth-integration-name">阿里云 Tair 社区版</div>
                            <div title="阿里云 Tair 社区版指标展示，包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。" class="fth-integration-desc">阿里云 Tair 社区版指标展示，包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../apache"
  				data-tags="中间件,WEB SERVER"
  				data-name="Apache"
  				data-summary="Apache 采集器可以从 Apache 服务中采集请求数、连接数等"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apache/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Apache" class="fth-integration-name">Apache</div>
                            <div title="Apache 采集器可以从 Apache 服务中采集请求数、连接数等" class="fth-integration-desc">Apache 采集器可以从 Apache 服务中采集请求数、连接数等</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../apisix"
  				data-tags=""
  				data-name="APISIX"
  				data-summary="采集 APISIX 相关指标、日志、链路信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apisix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="APISIX" class="fth-integration-name">APISIX</div>
                            <div title="采集 APISIX 相关指标、日志、链路信息" class="fth-integration-desc">采集 APISIX 相关指标、日志、链路信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../apollo"
  				data-tags=""
  				data-name="Apollo"
  				data-summary="采集 Apollo 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apollo/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Apollo" class="fth-integration-name">Apollo</div>
                            <div title="采集 Apollo 相关指标信息" class="fth-integration-desc">采集 Apollo 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../argocd"
  				data-tags=""
  				data-name="ArgoCD"
  				data-summary="采集 Argo CD 服务状态和应用状态及日志、链路信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/argocd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="ArgoCD" class="fth-integration-name">ArgoCD</div>
                            <div title="采集 Argo CD 服务状态和应用状态及日志、链路信息" class="fth-integration-desc">采集 Argo CD 服务状态和应用状态及日志、链路信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../automq"
  				data-tags=""
  				data-name="AutoMQ"
  				data-summary="采集 AutoMQ 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/automq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AutoMQ" class="fth-integration-name">AutoMQ</div>
                            <div title="采集 AutoMQ 相关指标信息" class="fth-integration-desc">采集 AutoMQ 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_api_gateway"
  				data-tags="AWS"
  				data-name="AWS API Gateway"
  				data-summary="AWS API Gateway的展示指标包括请求响应时间、吞吐量、并发连接数和错误率，这些指标反映了API Gateway在处理API请求和流量管理时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_api_gateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS API Gateway" class="fth-integration-name">AWS API Gateway</div>
                            <div title="AWS API Gateway的展示指标包括请求响应时间、吞吐量、并发连接数和错误率，这些指标反映了API Gateway在处理API请求和流量管理时的性能表现和可靠性。" class="fth-integration-desc">AWS API Gateway的展示指标包括请求响应时间、吞吐量、并发连接数和错误率，这些指标反映了API Gateway在处理API请求和流量管理时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_auto_scaling"
  				data-tags="AWS"
  				data-name="AWS Auto Scaling"
  				data-summary="AWS Auto Scaling，包括实例数、容量单位、暖池等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_auto_scaling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Auto Scaling" class="fth-integration-name">AWS Auto Scaling</div>
                            <div title="AWS Auto Scaling，包括实例数、容量单位、暖池等。" class="fth-integration-desc">AWS Auto Scaling，包括实例数、容量单位、暖池等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_billing"
  				data-tags="AWS"
  				data-name="AWS 云账单"
  				data-summary="采集 AWS 云账单信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS 云账单" class="fth-integration-name">AWS 云账单</div>
                            <div title="采集 AWS 云账单信息" class="fth-integration-desc">采集 AWS 云账单信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_cloudfront"
  				data-tags="AWS"
  				data-name="AWS CloudFront"
  				data-summary="AWS CloudFront的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_cloudfront/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS CloudFront" class="fth-integration-name">AWS CloudFront</div>
                            <div title="AWS CloudFront的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。" class="fth-integration-desc">AWS CloudFront的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_dms"
  				data-tags="AWS"
  				data-name="AWS DMS"
  				data-summary="AWS DMS的展示指标包括数据迁移速度、延迟、数据一致性和迁移成功率，这些指标反映了DMS在进行数据库迁移和复制时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dms/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS DMS" class="fth-integration-name">AWS DMS</div>
                            <div title="AWS DMS的展示指标包括数据迁移速度、延迟、数据一致性和迁移成功率，这些指标反映了DMS在进行数据库迁移和复制时的性能表现和可靠性。" class="fth-integration-desc">AWS DMS的展示指标包括数据迁移速度、延迟、数据一致性和迁移成功率，这些指标反映了DMS在进行数据库迁移和复制时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_documentdb"
  				data-tags="AWS"
  				data-name="AWS DocumentDB"
  				data-summary="AWS DocumentDB 的展示指标包括读取和写入吞吐量、查询延迟和可扩展性等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_documentdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS DocumentDB" class="fth-integration-name">AWS DocumentDB</div>
                            <div title="AWS DocumentDB 的展示指标包括读取和写入吞吐量、查询延迟和可扩展性等。" class="fth-integration-desc">AWS DocumentDB 的展示指标包括读取和写入吞吐量、查询延迟和可扩展性等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_dynamodb"
  				data-tags="AWS"
  				data-name="AWS DynamoDB"
  				data-summary="AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS DynamoDB" class="fth-integration-name">AWS DynamoDB</div>
                            <div title="AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。" class="fth-integration-desc">AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_dynamodb_DAX"
  				data-tags="AWS"
  				data-name="AWS DynamoDB DAX"
  				data-summary="AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb_DAX/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS DynamoDB DAX" class="fth-integration-name">AWS DynamoDB DAX</div>
                            <div title="AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。" class="fth-integration-desc">AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_ec2"
  				data-tags="AWS"
  				data-name="AWS EC2"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS EC2" class="fth-integration-name">AWS EC2</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_ec2_spot"
  				data-tags="AWS"
  				data-name="Amazon EC2 Spot"
  				data-summary=" Amazon EC2 Spot，包括请求容量池、目标容量池、中止容量等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2_spot/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Amazon EC2 Spot" class="fth-integration-name">Amazon EC2 Spot</div>
                            <div title=" Amazon EC2 Spot，包括请求容量池、目标容量池、中止容量等。" class="fth-integration-desc"> Amazon EC2 Spot，包括请求容量池、目标容量池、中止容量等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_ecs"
  				data-tags="AWS"
  				data-name="AWS ECS"
  				data-summary="Amazon ECS 功能与 亚马逊云科技 Fargate 无服务器计算引擎集成，使用<<< custom_key.brand_name >>>监控其服务运行态。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS ECS" class="fth-integration-name">AWS ECS</div>
                            <div title="Amazon ECS 功能与 亚马逊云科技 Fargate 无服务器计算引擎集成，使用<<< custom_key.brand_name >>>监控其服务运行态。" class="fth-integration-desc">Amazon ECS 功能与 亚马逊云科技 Fargate 无服务器计算引擎集成，使用<<< custom_key.brand_name >>>监控其服务运行态。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_elasticache_redis"
  				data-tags="AWS"
  				data-name="AWS ElastiCache Redis"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS ElastiCache Redis" class="fth-integration-name">AWS ElastiCache Redis</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_elasticache_serverless"
  				data-tags="AWS"
  				data-name="AWS ElastiCache Serverless"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_serverless/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS ElastiCache Serverless" class="fth-integration-name">AWS ElastiCache Serverless</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_elb"
  				data-tags="AWS"
  				data-name="AWS ELB"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS ELB" class="fth-integration-name">AWS ELB</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_emr"
  				data-tags="AWS"
  				data-name="AWS EMR"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_emr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS EMR" class="fth-integration-name">AWS EMR</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_eventbridge"
  				data-tags="AWS"
  				data-name="AWS EventBridge"
  				data-summary="AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_eventbridge/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS EventBridge" class="fth-integration-name">AWS EventBridge</div>
                            <div title="AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。" class="fth-integration-desc">AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_hirehose_http_endpoint"
  				data-tags="Amazon Firehose,HTTP Endpoint,Kinesis Data Stream"
  				data-name="AWS Firehose HTTP Endpoint"
  				data-summary="将 Firehose 的日志或者指标发送到观测云"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Firehose HTTP Endpoint" class="fth-integration-name">AWS Firehose HTTP Endpoint</div>
                            <div title="将 Firehose 的日志或者指标发送到观测云" class="fth-integration-desc">将 Firehose 的日志或者指标发送到观测云</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_kinesis"
  				data-tags="AWS"
  				data-name="AWS Kinesis"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Kinesis" class="fth-integration-name">AWS Kinesis</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_kinesis_analytics"
  				data-tags="AWS"
  				data-name="AWS KinesisAnalytics"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis_analytics/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS KinesisAnalytics" class="fth-integration-name">AWS KinesisAnalytics</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_lambda"
  				data-tags="AWS"
  				data-name="AWS Lambda"
  				data-summary="AWS Lambda的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Lambda函数的响应速度、可扩展性和资源利用情况。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_lambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Lambda" class="fth-integration-name">AWS Lambda</div>
                            <div title="AWS Lambda的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Lambda函数的响应速度、可扩展性和资源利用情况。" class="fth-integration-desc">AWS Lambda的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Lambda函数的响应速度、可扩展性和资源利用情况。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_mediaconvert"
  				data-tags="AWS"
  				data-name="AWS MediaConvert"
  				data-summary=" AWS MediaConvert，包括数据传输、视频报错、作业数、填充等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_mediaconvert/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS MediaConvert" class="fth-integration-name">AWS MediaConvert</div>
                            <div title=" AWS MediaConvert，包括数据传输、视频报错、作业数、填充等。" class="fth-integration-desc"> AWS MediaConvert，包括数据传输、视频报错、作业数、填充等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_memorydb"
  				data-tags="AWS"
  				data-name="AWS MemoryDB"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_memorydb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS MemoryDB" class="fth-integration-name">AWS MemoryDB</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_mq_rabbitmq"
  				data-tags="AWS"
  				data-name="Amazon MQ for RabbitMQ"
  				data-summary="Amazon MQ 支持行业标准 API 和协议，对消息代理的管理和维护进行管理，并自动为高可用性提供基础设施。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_mq_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Amazon MQ for RabbitMQ" class="fth-integration-name">Amazon MQ for RabbitMQ</div>
                            <div title="Amazon MQ 支持行业标准 API 和协议，对消息代理的管理和维护进行管理，并自动为高可用性提供基础设施。" class="fth-integration-desc">Amazon MQ 支持行业标准 API 和协议，对消息代理的管理和维护进行管理，并自动为高可用性提供基础设施。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_msk"
  				data-tags="AWS"
  				data-name="AWS MSK"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_msk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS MSK" class="fth-integration-name">AWS MSK</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_neptune_cluster"
  				data-tags="AWS"
  				data-name="AWS Neptune Cluster"
  				data-summary="AWS Neptune Cluster的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Neptune Cluster函数的响应速度、可扩展性和资源利用情况。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_neptune_cluster/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Neptune Cluster" class="fth-integration-name">AWS Neptune Cluster</div>
                            <div title="AWS Neptune Cluster的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Neptune Cluster函数的响应速度、可扩展性和资源利用情况。" class="fth-integration-desc">AWS Neptune Cluster的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Neptune Cluster函数的响应速度、可扩展性和资源利用情况。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_opensearch"
  				data-tags="AWS"
  				data-name="AWS OpenSearch"
  				data-summary="AWS OpenSearch，包括连接数、请求数、时延、慢查询等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_opensearch/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS OpenSearch" class="fth-integration-name">AWS OpenSearch</div>
                            <div title="AWS OpenSearch，包括连接数、请求数、时延、慢查询等。" class="fth-integration-desc">AWS OpenSearch，包括连接数、请求数、时延、慢查询等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_rds_mysql"
  				data-tags="AWS"
  				data-name="AWS RDS MySQL"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS RDS MySQL" class="fth-integration-name">AWS RDS MySQL</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_redshift"
  				data-tags="AWS"
  				data-name="AWS Redshift"
  				data-summary="AWS Redshift的核心性能指标包括查询性能、磁盘空间使用率、CPU利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_redshift/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Redshift" class="fth-integration-name">AWS Redshift</div>
                            <div title="AWS Redshift的核心性能指标包括查询性能、磁盘空间使用率、CPU利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。" class="fth-integration-desc">AWS Redshift的核心性能指标包括查询性能、磁盘空间使用率、CPU利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_s3"
  				data-tags="AWS"
  				data-name="AWS S3"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_s3/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS S3" class="fth-integration-name">AWS S3</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_sqs"
  				data-tags="AWS"
  				data-name="AWS Simple Queue Service"
  				data-summary="AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_sqs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Simple Queue Service" class="fth-integration-name">AWS Simple Queue Service</div>
                            <div title="AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。" class="fth-integration-desc">AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_timestream"
  				data-tags="AWS"
  				data-name="AWS Timestream"
  				data-summary="AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量，以及存储在磁存储器中的数据量等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_timestream/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Timestream" class="fth-integration-name">AWS Timestream</div>
                            <div title="AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量，以及存储在磁存储器中的数据量等。" class="fth-integration-desc">AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量，以及存储在磁存储器中的数据量等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../awslambda"
  				data-tags="AWS"
  				data-name="AWS Lambda 扩展"
  				data-summary="通过 AWS Lambda 扩展采集数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/awslambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Lambda 扩展" class="fth-integration-name">AWS Lambda 扩展</div>
                            <div title="通过 AWS Lambda 扩展采集数据" class="fth-integration-desc">通过 AWS Lambda 扩展采集数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_kubernetes"
  				data-tags="AZURE"
  				data-name="Azure Kubernetes"
  				data-summary="采集 Azure Kubernetes 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Kubernetes" class="fth-integration-name">Azure Kubernetes</div>
                            <div title="采集 Azure Kubernetes 指标数据" class="fth-integration-desc">采集 Azure Kubernetes 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_load_balancer"
  				data-tags="AZURE"
  				data-name="Azure Load Balancer"
  				data-summary="采集 Azure Load Balancer 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_load_balancer/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Load Balancer" class="fth-integration-name">Azure Load Balancer</div>
                            <div title="采集 Azure Load Balancer 指标数据" class="fth-integration-desc">采集 Azure Load Balancer 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_mysql"
  				data-tags="AZURE"
  				data-name="Azure MySQL"
  				data-summary="采集 Azure MySQL 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure MySQL" class="fth-integration-name">Azure MySQL</div>
                            <div title="采集 Azure MySQL 指标数据" class="fth-integration-desc">采集 Azure MySQL 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_network_interfaces"
  				data-tags="AZURE"
  				data-name="Azure Network Interfaces"
  				data-summary="采集 Azure Network Interface 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_network_interfaces/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Network Interfaces" class="fth-integration-name">Azure Network Interfaces</div>
                            <div title="采集 Azure Network Interface 指标数据" class="fth-integration-desc">采集 Azure Network Interface 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_postgresql"
  				data-tags="AZURE"
  				data-name="Azure PostgreSQL"
  				data-summary="采集 Azure PostgreSQL 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure PostgreSQL" class="fth-integration-name">Azure PostgreSQL</div>
                            <div title="采集 Azure PostgreSQL 指标数据" class="fth-integration-desc">采集 Azure PostgreSQL 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_public_ip"
  				data-tags="AZURE,网络"
  				data-name="Azure Public Ip Address"
  				data-summary="采集 Azure Public Ip Address 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_public_ip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Public Ip Address" class="fth-integration-name">Azure Public Ip Address</div>
                            <div title="采集 Azure Public Ip Address 指标数据" class="fth-integration-desc">采集 Azure Public Ip Address 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_redis_cache"
  				data-tags="AZURE"
  				data-name="Azure Redis Cache"
  				data-summary="采集 Azure Redis Cache 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_redis_cache/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Redis Cache" class="fth-integration-name">Azure Redis Cache</div>
                            <div title="采集 Azure Redis Cache 指标数据" class="fth-integration-desc">采集 Azure Redis Cache 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_sqlserver"
  				data-tags="AZURE"
  				data-name="Azure SQL Servers"
  				data-summary="采集 Azure SQL Servers 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure SQL Servers" class="fth-integration-name">Azure SQL Servers</div>
                            <div title="采集 Azure SQL Servers 指标数据" class="fth-integration-desc">采集 Azure SQL Servers 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_storage"
  				data-tags="AZURE"
  				data-name="Azure Storage"
  				data-summary="采集 Azure Storage 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_storage/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Storage" class="fth-integration-name">Azure Storage</div>
                            <div title="采集 Azure Storage 指标数据" class="fth-integration-desc">采集 Azure Storage 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_virtual_network_gateway"
  				data-tags="AZURE"
  				data-name="Azure Virtual Network Gateway"
  				data-summary="采集 Azure Virtual Network Gateway 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_virtual_network_gateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Virtual Network Gateway" class="fth-integration-name">Azure Virtual Network Gateway</div>
                            <div title="采集 Azure Virtual Network Gateway 指标数据" class="fth-integration-desc">采集 Azure Virtual Network Gateway 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../azure_vm"
  				data-tags="AZURE"
  				data-name="Azure Virtual Machines"
  				data-summary="采集 Azure Virtual Machines 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_vm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Virtual Machines" class="fth-integration-name">Azure Virtual Machines</div>
                            <div title="采集 Azure Virtual Machines 指标数据" class="fth-integration-desc">采集 Azure Virtual Machines 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../beats_output"
  				data-tags="日志"
  				data-name="Filebeat"
  				data-summary="接收 Filebeat 采集的日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/beats/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Filebeat" class="fth-integration-name">Filebeat</div>
                            <div title="接收 Filebeat 采集的日志数据" class="fth-integration-desc">接收 Filebeat 采集的日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cassandra"
  				data-tags="数据库"
  				data-name="Cassandra"
  				data-summary="采集 Cassandra 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Cassandra" class="fth-integration-name">Cassandra</div>
                            <div title="采集 Cassandra 的指标数据" class="fth-integration-desc">采集 Cassandra 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cat"
  				data-tags="链路追踪"
  				data-name="点评 CAT"
  				data-summary="美团点评的性能、容量和业务指标监控系统"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="点评 CAT" class="fth-integration-name">点评 CAT</div>
                            <div title="美团点评的性能、容量和业务指标监控系统" class="fth-integration-desc">美团点评的性能、容量和业务指标监控系统</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../chrony"
  				data-tags=""
  				data-name="Chrony"
  				data-summary="采集 Chrony 服务器相关的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/chrony/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Chrony" class="fth-integration-name">Chrony</div>
                            <div title="采集 Chrony 服务器相关的指标数据" class="fth-integration-desc">采集 Chrony 服务器相关的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../clickhousev1"
  				data-tags="数据库"
  				data-name="ClickHouse"
  				data-summary="采集 ClickHouse 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/clickhouse/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="ClickHouse" class="fth-integration-name">ClickHouse</div>
                            <div title="采集 ClickHouse 的指标数据" class="fth-integration-desc">采集 ClickHouse 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cloud-charges"
  				data-tags=""
  				data-name="云账单费用查询"
  				data-summary="云账单费用查询，可以查询 AWS 、华为云、阿里云、腾讯云等公有云账单信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cloud_billing//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="云账单费用查询" class="fth-integration-name">云账单费用查询</div>
                            <div title="云账单费用查询，可以查询 AWS 、华为云、阿里云、腾讯云等公有云账单信息" class="fth-integration-desc">云账单费用查询，可以查询 AWS 、华为云、阿里云、腾讯云等公有云账单信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cloudprober"
  				data-tags=""
  				data-name="Cloudprober"
  				data-summary="接收 Cloudprober 数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cloudprober/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Cloudprober" class="fth-integration-name">Cloudprober</div>
                            <div title="接收 Cloudprober 数据" class="fth-integration-desc">接收 Cloudprober 数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cockroachdb"
  				data-tags="数据库"
  				data-name="CockroachDB"
  				data-summary="采集 CockroachDB 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cockroachdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="CockroachDB" class="fth-integration-name">CockroachDB</div>
                            <div title="采集 CockroachDB 的指标数据" class="fth-integration-desc">采集 CockroachDB 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../confluent_cloud"
  				data-tags="中间件"
  				data-name="Confluent Cloud"
  				data-summary="从 Confluent Cloud 采集 Kafka 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/confluent/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Confluent Cloud" class="fth-integration-name">Confluent Cloud</div>
                            <div title="从 Confluent Cloud 采集 Kafka 指标数据" class="fth-integration-desc">从 Confluent Cloud 采集 Kafka 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../consul"
  				data-tags="中间件"
  				data-name="Consul"
  				data-summary="采集 Consul 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/consul/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Consul" class="fth-integration-name">Consul</div>
                            <div title="采集 Consul 的指标数据" class="fth-integration-desc">采集 Consul 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../container-log"
  				data-tags="日志,容器,KUBERNETES"
  				data-name="Kubernetes 日志"
  				data-summary="采集 Container 和 Kubernetes 日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes 日志" class="fth-integration-name">Kubernetes 日志</div>
                            <div title="采集 Container 和 Kubernetes 日志数据" class="fth-integration-desc">采集 Container 和 Kubernetes 日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../container"
  				data-tags="KUBERNETES,容器"
  				data-name="Kubernetes"
  				data-summary="采集 Container 和 Kubernetes 的指标、对象和日志数据，上报到<<<custom_key.brand_name>>>。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes" class="fth-integration-name">Kubernetes</div>
                            <div title="采集 Container 和 Kubernetes 的指标、对象和日志数据，上报到<<<custom_key.brand_name>>>。" class="fth-integration-desc">采集 Container 和 Kubernetes 的指标、对象和日志数据，上报到<<<custom_key.brand_name>>>。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../coredns"
  				data-tags="中间件"
  				data-name="CoreDNS"
  				data-summary="采集 CoreDNS 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/coredns/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="CoreDNS" class="fth-integration-name">CoreDNS</div>
                            <div title="采集 CoreDNS 的指标数据" class="fth-integration-desc">采集 CoreDNS 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../couchbase"
  				data-tags="数据库"
  				data-name="Couchbase"
  				data-summary="采集 Couchbase 服务器相关的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/couchbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Couchbase" class="fth-integration-name">Couchbase</div>
                            <div title="采集 Couchbase 服务器相关的指标数据" class="fth-integration-desc">采集 Couchbase 服务器相关的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../couchdb"
  				data-tags="数据库"
  				data-name="CouchDB"
  				data-summary="采集 CouchDB 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/couchdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="CouchDB" class="fth-integration-name">CouchDB</div>
                            <div title="采集 CouchDB 的指标数据" class="fth-integration-desc">采集 CouchDB 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../cpu"
  				data-tags="HOST"
  				data-name="CPU"
  				data-summary="采集 CPU 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cpu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="CPU" class="fth-integration-name">CPU</div>
                            <div title="采集 CPU 指标数据" class="fth-integration-desc">采集 CPU 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../db2"
  				data-tags="数据库"
  				data-name="DB2"
  				data-summary="采集 IBM DB2 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/db2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DB2" class="fth-integration-name">DB2</div>
                            <div title="采集 IBM DB2 的指标数据" class="fth-integration-desc">采集 IBM DB2 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-attach"
  				data-tags="链路追踪,JAVA"
  				data-name="自动注入 DDTrace-Java Agent"
  				data-summary="DDTrace Java 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="自动注入 DDTrace-Java Agent" class="fth-integration-name">自动注入 DDTrace-Java Agent</div>
                            <div title="DDTrace Java 集成" class="fth-integration-desc">DDTrace Java 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-cpp"
  				data-tags="链路追踪,C/C++"
  				data-name="DDTrace C++"
  				data-summary="DDTrace C++ 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace C++" class="fth-integration-name">DDTrace C++</div>
                            <div title="DDTrace C++ 集成" class="fth-integration-desc">DDTrace C++ 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-ext-java"
  				data-tags="DDTRACE,链路追踪"
  				data-name="DDTrace 扩展"
  				data-summary="<<<custom_key.brand_name>>>扩展了 DDTrace 对组建的支持"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace 扩展" class="fth-integration-name">DDTrace 扩展</div>
                            <div title="<<<custom_key.brand_name>>>扩展了 DDTrace 对组建的支持" class="fth-integration-desc"><<<custom_key.brand_name>>>扩展了 DDTrace 对组建的支持</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-golang"
  				data-tags="DDTRACE,GOLANG,链路追踪"
  				data-name="DDTrace Golang"
  				data-summary="DDTrace Golang 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Golang" class="fth-integration-name">DDTrace Golang</div>
                            <div title="DDTrace Golang 集成" class="fth-integration-desc">DDTrace Golang 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-java"
  				data-tags="DDTRACE,JAVA,链路追踪"
  				data-name="DDTrace Java"
  				data-summary="DDTrace Java 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Java" class="fth-integration-name">DDTrace Java</div>
                            <div title="DDTrace Java 集成" class="fth-integration-desc">DDTrace Java 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-jmxfetch"
  				data-tags="DDTRACE,JAVA,链路追踪"
  				data-name="DDTrace JMX"
  				data-summary="DDTrace JMX 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace JMX" class="fth-integration-name">DDTrace JMX</div>
                            <div title="DDTrace JMX 集成" class="fth-integration-desc">DDTrace JMX 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-nodejs"
  				data-tags="DDTRACE,NODEJS,链路追踪"
  				data-name="DDTrace NodeJS"
  				data-summary="DDTrace NodeJS 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace NodeJS" class="fth-integration-name">DDTrace NodeJS</div>
                            <div title="DDTrace NodeJS 集成" class="fth-integration-desc">DDTrace NodeJS 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-php"
  				data-tags="DDTRACE,PHP,链路追踪"
  				data-name="DDTrace PHP"
  				data-summary="DDTrace PHP 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace PHP" class="fth-integration-name">DDTrace PHP</div>
                            <div title="DDTrace PHP 集成" class="fth-integration-desc">DDTrace PHP 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-python"
  				data-tags="DDTRACE,PYTHON,链路追踪"
  				data-name="DDTrace Python"
  				data-summary="DDTrace Python 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Python" class="fth-integration-name">DDTrace Python</div>
                            <div title="DDTrace Python 集成" class="fth-integration-desc">DDTrace Python 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace-ruby"
  				data-tags="DDTRACE,RUBY,链路追踪"
  				data-name="DDTrace Ruby"
  				data-summary="DDTrace Ruby 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Ruby" class="fth-integration-name">DDTrace Ruby</div>
                            <div title="DDTrace Ruby 集成" class="fth-integration-desc">DDTrace Ruby 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ddtrace"
  				data-tags="DDTRACE,链路追踪"
  				data-name="DDTrace"
  				data-summary="接收 DDTrace 的 APM 数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace" class="fth-integration-name">DDTrace</div>
                            <div title="接收 DDTrace 的 APM 数据" class="fth-integration-desc">接收 DDTrace 的 APM 数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dialtesting"
  				data-tags="拨测,网络"
  				data-name="网络拨测"
  				data-summary="通过网络拨测来获取网络性能表现"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="网络拨测" class="fth-integration-name">网络拨测</div>
                            <div title="通过网络拨测来获取网络性能表现" class="fth-integration-desc">通过网络拨测来获取网络性能表现</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dialtesting_json"
  				data-tags="拨测,网络"
  				data-name="自定义拨测任务"
  				data-summary="自定义拨测采集器来定制拨测任务"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="自定义拨测任务" class="fth-integration-name">自定义拨测任务</div>
                            <div title="自定义拨测采集器来定制拨测任务" class="fth-integration-desc">自定义拨测采集器来定制拨测任务</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../disk"
  				data-tags="主机"
  				data-name="磁盘"
  				data-summary="采集磁盘的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/disk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="磁盘" class="fth-integration-name">磁盘</div>
                            <div title="采集磁盘的指标数据" class="fth-integration-desc">采集磁盘的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../diskio"
  				data-tags="主机"
  				data-name="磁盘 IO"
  				data-summary="采集磁盘 IO 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/diskio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="磁盘 IO" class="fth-integration-name">磁盘 IO</div>
                            <div title="采集磁盘 IO 指标数据" class="fth-integration-desc">采集磁盘 IO 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dk"
  				data-tags="主机"
  				data-name="DataKit 自身指标采集"
  				data-summary="采集 Datakit 自身运行指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DataKit 自身指标采集" class="fth-integration-name">DataKit 自身指标采集</div>
                            <div title="采集 Datakit 自身运行指标" class="fth-integration-desc">采集 Datakit 自身运行指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dm_v8"
  				data-tags=""
  				data-name="达梦数据库（DM8）"
  				data-summary="采集达梦数据库运行指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="达梦数据库（DM8）" class="fth-integration-name">达梦数据库（DM8）</div>
                            <div title="采集达梦数据库运行指标信息" class="fth-integration-desc">采集达梦数据库运行指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../docker"
  				data-tags="容器"
  				data-name="Docker"
  				data-summary="采集 Docker Container的指标、对象和日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/docker/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Docker" class="fth-integration-name">Docker</div>
                            <div title="采集 Docker Container的指标、对象和日志数据" class="fth-integration-desc">采集 Docker Container的指标、对象和日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dongfangtong_ths"
  				data-tags=""
  				data-name="东方通 THS（TongHttpServer）"
  				data-summary="采集东方通 THS（TongHttpServer）运行指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="东方通 THS（TongHttpServer）" class="fth-integration-name">东方通 THS（TongHttpServer）</div>
                            <div title="采集东方通 THS（TongHttpServer）运行指标信息" class="fth-integration-desc">采集东方通 THS（TongHttpServer）运行指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dongfangtong_tweb"
  				data-tags=""
  				data-name="东方通 TWeb（TongWeb）"
  				data-summary="采集东方通 TWeb（TongWeb）运行指标及链路信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="东方通 TWeb（TongWeb）" class="fth-integration-name">东方通 TWeb（TongWeb）</div>
                            <div title="采集东方通 TWeb（TongWeb）运行指标及链路信息" class="fth-integration-desc">采集东方通 TWeb（TongWeb）运行指标及链路信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../doris"
  				data-tags="数据库"
  				data-name="Doris"
  				data-summary="采集 Doris 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/doris/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Doris" class="fth-integration-name">Doris</div>
                            <div title="采集 Doris 的指标数据" class="fth-integration-desc">采集 Doris 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../dotnet"
  				data-tags=""
  				data-name=".NET"
  				data-summary="采集 .NET 应用相关 Metrics、Tracing、Logging 和 Profiling 信息。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dotnet/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title=".NET" class="fth-integration-name">.NET</div>
                            <div title="采集 .NET 应用相关 Metrics、Tracing、Logging 和 Profiling 信息。" class="fth-integration-desc">采集 .NET 应用相关 Metrics、Tracing、Logging 和 Profiling 信息。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../druid"
  				data-tags=""
  				data-name="Druid"
  				data-summary="采集 Druid 数据库连接池相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/druid/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Druid" class="fth-integration-name">Druid</div>
                            <div title="采集 Druid 数据库连接池相关指标信息" class="fth-integration-desc">采集 Druid 数据库连接池相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ebpf"
  				data-tags="EBPF,NETWORK"
  				data-name="eBPF"
  				data-summary="通过 eBPF 采集 Linux 网络数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ebpf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="eBPF" class="fth-integration-name">eBPF</div>
                            <div title="通过 eBPF 采集 Linux 网络数据" class="fth-integration-desc">通过 eBPF 采集 Linux 网络数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ebpftrace"
  				data-tags="链路追踪,EBPF"
  				data-name="eBPF Tracing"
  				data-summary="关联 eBPF 采集的链路 span，生成链路"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ebpf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="eBPF Tracing" class="fth-integration-name">eBPF Tracing</div>
                            <div title="关联 eBPF 采集的链路 span，生成链路" class="fth-integration-desc">关联 eBPF 采集的链路 span，生成链路</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../elasticsearch"
  				data-tags="数据库"
  				data-name="ElasticSearch"
  				data-summary="采集 ElasticSearch 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/elasticsearch/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="ElasticSearch" class="fth-integration-name">ElasticSearch</div>
                            <div title="采集 ElasticSearch 的指标数据" class="fth-integration-desc">采集 ElasticSearch 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../emqx"
  				data-tags=""
  				data-name="EMQX"
  				data-summary="采集 EMQX collection、topics、subsriptions、message、packet 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/emqx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="EMQX" class="fth-integration-name">EMQX</div>
                            <div title="采集 EMQX collection、topics、subsriptions、message、packet 相关指标信息" class="fth-integration-desc">采集 EMQX collection、topics、subsriptions、message、packet 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../etcd"
  				data-tags="中间件"
  				data-name="etcd"
  				data-summary="采集 etcd 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/etcd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="etcd" class="fth-integration-name">etcd</div>
                            <div title="采集 etcd 的指标数据" class="fth-integration-desc">采集 etcd 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../exchange"
  				data-tags=""
  				data-name="Exchange"
  				data-summary="采集 Exchange 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/exchange/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Exchange" class="fth-integration-name">Exchange</div>
                            <div title="采集 Exchange 相关指标信息" class="fth-integration-desc">采集 Exchange 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../external"
  				data-tags=""
  				data-name="External"
  				data-summary="启动外部程序进行采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/external/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="External" class="fth-integration-name">External</div>
                            <div title="启动外部程序进行采集" class="fth-integration-desc">启动外部程序进行采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../flinkv1"
  				data-tags="中间件"
  				data-name="Flink"
  				data-summary="采集 Flink 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/flink/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Flink" class="fth-integration-name">Flink</div>
                            <div title="采集 Flink 的指标数据" class="fth-integration-desc">采集 Flink 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../fluent_bit"
  				data-tags=""
  				data-name="Fluent Bit"
  				data-summary="通过 Fluent Bit 采集日志"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/fluentbit/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Fluent Bit" class="fth-integration-name">Fluent Bit</div>
                            <div title="通过 Fluent Bit 采集日志" class="fth-integration-desc">通过 Fluent Bit 采集日志</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../fluentd"
  				data-tags=""
  				data-name="Fluentd"
  				data-summary="采集 Fluentd 的日志"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/fluentd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Fluentd" class="fth-integration-name">Fluentd</div>
                            <div title="采集 Fluentd 的日志" class="fth-integration-desc">采集 Fluentd 的日志</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../gcp_ce"
  				data-tags="GCP"
  				data-name="GCP Compute Engine"
  				data-summary="采集 GCP Compute Engine 虚拟机CPU、内存、磁盘、网络等资源指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gcp_ce/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="GCP Compute Engine" class="fth-integration-name">GCP Compute Engine</div>
                            <div title="采集 GCP Compute Engine 虚拟机CPU、内存、磁盘、网络等资源指标" class="fth-integration-desc">采集 GCP Compute Engine 虚拟机CPU、内存、磁盘、网络等资源指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../gitlab"
  				data-tags="GITLAB,CI/CD"
  				data-name="GitLab"
  				data-summary="采集 GitLab 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gitlab/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="GitLab" class="fth-integration-name">GitLab</div>
                            <div title="采集 GitLab 的指标数据" class="fth-integration-desc">采集 GitLab 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../golang"
  				data-tags=""
  				data-name="Golang"
  				data-summary="获取 Golang 应用的指标、链路追踪和日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/go/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Golang" class="fth-integration-name">Golang</div>
                            <div title="获取 Golang 应用的指标、链路追踪和日志信息" class="fth-integration-desc">获取 Golang 应用的指标、链路追踪和日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../gpu_smi"
  				data-tags="主机"
  				data-name="GPU"
  				data-summary="采集 NVIDIA GPU 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gpu_smi/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="GPU" class="fth-integration-name">GPU</div>
                            <div title="采集 NVIDIA GPU 指标数据" class="fth-integration-desc">采集 NVIDIA GPU 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../grafana-guance-data-source"
  				data-tags=""
  				data-name="Grafana Guance Datasource"
  				data-summary="Grafana 接入<<< custom_key.brand_name >>>数据提供的 Datasource 源"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/grafana_datasource/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Grafana Guance Datasource" class="fth-integration-name">Grafana Guance Datasource</div>
                            <div title="Grafana 接入<<< custom_key.brand_name >>>数据提供的 Datasource 源" class="fth-integration-desc">Grafana 接入<<< custom_key.brand_name >>>数据提供的 Datasource 源</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../graphite"
  				data-tags="外部数据接入"
  				data-name="Graphite"
  				data-summary="采集 Graphite Exporter 暴露的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/graphite/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Graphite" class="fth-integration-name">Graphite</div>
                            <div title="采集 Graphite Exporter 暴露的指标数据" class="fth-integration-desc">采集 Graphite Exporter 暴露的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../greenplum"
  				data-tags=""
  				data-name="GreenPlum"
  				data-summary="采集 greenplum 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/greenplum/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="GreenPlum" class="fth-integration-name">GreenPlum</div>
                            <div title="采集 greenplum 指标信息" class="fth-integration-desc">采集 greenplum 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hadoop_hdfs_datanode"
  				data-tags=""
  				data-name="Hadoop HDFS DataNode"
  				data-summary="采集 HDFS datanode 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-hdfs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Hadoop HDFS DataNode" class="fth-integration-name">Hadoop HDFS DataNode</div>
                            <div title="采集 HDFS datanode 指标信息" class="fth-integration-desc">采集 HDFS datanode 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hadoop_hdfs_namenode"
  				data-tags=""
  				data-name="Hadoop HDFS NameNode"
  				data-summary="采集 HDFS namenode 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-hdfs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Hadoop HDFS NameNode" class="fth-integration-name">Hadoop HDFS NameNode</div>
                            <div title="采集 HDFS namenode 指标信息" class="fth-integration-desc">采集 HDFS namenode 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hadoop_yarn_nodemanager"
  				data-tags=""
  				data-name="Hadoop Yarn NodeManager"
  				data-summary="采集 Yarn NodeManager 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-yarn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Hadoop Yarn NodeManager" class="fth-integration-name">Hadoop Yarn NodeManager</div>
                            <div title="采集 Yarn NodeManager 指标信息" class="fth-integration-desc">采集 Yarn NodeManager 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hadoop_yarn_resourcemanager"
  				data-tags=""
  				data-name="Hadoop Yarn ResourceManager"
  				data-summary="采集 Yarn ResourceManager 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-yarn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Hadoop Yarn ResourceManager" class="fth-integration-name">Hadoop Yarn ResourceManager</div>
                            <div title="采集 Yarn ResourceManager 指标信息" class="fth-integration-desc">采集 Yarn ResourceManager 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../haproxy"
  				data-tags=""
  				data-name="Haproxy"
  				data-summary="采集 Haproxy 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/haproxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Haproxy" class="fth-integration-name">Haproxy</div>
                            <div title="采集 Haproxy 指标信息" class="fth-integration-desc">采集 Haproxy 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hbase_master"
  				data-tags=""
  				data-name="HBase Master"
  				data-summary="采集 HBase Master 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="HBase Master" class="fth-integration-name">HBase Master</div>
                            <div title="采集 HBase Master 指标信息" class="fth-integration-desc">采集 HBase Master 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hbase_region"
  				data-tags=""
  				data-name="HBase Region"
  				data-summary="采集 HBase Region 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="HBase Region" class="fth-integration-name">HBase Region</div>
                            <div title="采集 HBase Region 指标信息" class="fth-integration-desc">采集 HBase Region 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../host_healthcheck"
  				data-tags="主机"
  				data-name="主机健康检查"
  				data-summary="定期检查主机进程和网络健康状况"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/healthcheck/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="主机健康检查" class="fth-integration-name">主机健康检查</div>
                            <div title="定期检查主机进程和网络健康状况" class="fth-integration-desc">定期检查主机进程和网络健康状况</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../host_processes"
  				data-tags="主机"
  				data-name="进程"
  				data-summary="采集进程的指标和对象数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/process/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="进程" class="fth-integration-name">进程</div>
                            <div title="采集进程的指标和对象数据" class="fth-integration-desc">采集进程的指标和对象数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hostdir"
  				data-tags="主机"
  				data-name="文件目录"
  				data-summary="采集文件目录的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostdir/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="文件目录" class="fth-integration-name">文件目录</div>
                            <div title="采集文件目录的指标数据" class="fth-integration-desc">采集文件目录的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../hostobject"
  				data-tags="主机"
  				data-name="主机对象"
  				data-summary="采集主机基本信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostobject/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="主机对象" class="fth-integration-name">主机对象</div>
                            <div title="采集主机基本信息" class="fth-integration-desc">采集主机基本信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_FunctionGraph"
  				data-tags="华为云"
  				data-name="华为云 FunctionGraph"
  				data-summary="华为云 FunctionGraph的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了FunctionGraph函数运行情况。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_functiongraph/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 FunctionGraph" class="fth-integration-name">华为云 FunctionGraph</div>
                            <div title="华为云 FunctionGraph的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了FunctionGraph函数运行情况。" class="fth-integration-desc">华为云 FunctionGraph的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了FunctionGraph函数运行情况。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_SYS.AS"
  				data-tags="华为云"
  				data-name="HUAWEI AS"
  				data-summary="华为云 AS 的核心性能指标包括CPU利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_sys_as/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="HUAWEI AS" class="fth-integration-name">HUAWEI AS</div>
                            <div title="华为云 AS 的核心性能指标包括CPU利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。" class="fth-integration-desc">华为云 AS 的核心性能指标包括CPU利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_SYS.CBR"
  				data-tags="华为云"
  				data-name="华为云 CBR"
  				data-summary="华为云 CBR 的展示指标包括带宽利用率、延迟、丢包率和网络吞吐量，这些指标反映了CBR在网络传输和带宽管理方面的性能表现和质量保证。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_sys_cbr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 CBR" class="fth-integration-name">华为云 CBR</div>
                            <div title="华为云 CBR 的展示指标包括带宽利用率、延迟、丢包率和网络吞吐量，这些指标反映了CBR在网络传输和带宽管理方面的性能表现和质量保证。" class="fth-integration-desc">华为云 CBR 的展示指标包括带宽利用率、延迟、丢包率和网络吞吐量，这些指标反映了CBR在网络传输和带宽管理方面的性能表现和质量保证。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_SYS_DDMS"
  				data-tags="华为云"
  				data-name="华为云 DDM"
  				data-summary="华为云 DDM 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了DDMS在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huaweiyun_SYS_DDMS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DDM" class="fth-integration-name">华为云 DDM</div>
                            <div title="华为云 DDM 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了DDMS在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。" class="fth-integration-desc">华为云 DDM 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了DDMS在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_apic"
  				data-tags="华为云"
  				data-name="华为云 API"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_apic/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 API" class="fth-integration-name">华为云 API</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_asm"
  				data-tags="华为云"
  				data-name="华为云ASM链路追踪 TO <<< custom_key.brand_name >>>"
  				data-summary="华为云的ASM的链路追踪数据输出到<<< custom_key.brand_name >>>，进行查看、分析。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_asm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云ASM链路追踪 TO <<< custom_key.brand_name >>>" class="fth-integration-name">华为云ASM链路追踪 TO <<< custom_key.brand_name >>></div>
                            <div title="华为云的ASM的链路追踪数据输出到<<< custom_key.brand_name >>>，进行查看、分析。" class="fth-integration-desc">华为云的ASM的链路追踪数据输出到<<< custom_key.brand_name >>>，进行查看、分析。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_cce"
  				data-tags="华为云"
  				data-name="使用<<< custom_key.brand_name >>>采集华为云CCE指标数据"
  				data-summary="<<< custom_key.brand_name >>>支持对 CCE 中各类资源的运行状态和服务能力进行监测，包括 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_cce/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="使用<<< custom_key.brand_name >>>采集华为云CCE指标数据" class="fth-integration-name">使用<<< custom_key.brand_name >>>采集华为云CCE指标数据</div>
                            <div title="<<< custom_key.brand_name >>>支持对 CCE 中各类资源的运行状态和服务能力进行监测，包括 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等。" class="fth-integration-desc"><<< custom_key.brand_name >>>支持对 CCE 中各类资源的运行状态和服务能力进行监测，包括 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_css_es"
  				data-tags="华为云"
  				data-name="华为云搜索服务 CSS for Elasticsearch"
  				data-summary="采集 华为云搜索服务 CSS for Elasticsearch 监控指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_css_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云搜索服务 CSS for Elasticsearch" class="fth-integration-name">华为云搜索服务 CSS for Elasticsearch</div>
                            <div title="采集 华为云搜索服务 CSS for Elasticsearch 监控指标" class="fth-integration-desc">采集 华为云搜索服务 CSS for Elasticsearch 监控指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_dcaas"
  				data-tags="华为云"
  				data-name="华为云 DCAAS 云专线"
  				data-summary="采集华为云 DCAAS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dcaas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DCAAS 云专线" class="fth-integration-name">华为云 DCAAS 云专线</div>
                            <div title="采集华为云 DCAAS 指标数据" class="fth-integration-desc">采集华为云 DCAAS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_dcs"
  				data-tags="华为云"
  				data-name="华为云 DCS"
  				data-summary="采集华为云 DCS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dcs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DCS" class="fth-integration-name">华为云 DCS</div>
                            <div title="采集华为云 DCS 指标数据" class="fth-integration-desc">采集华为云 DCS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_dds"
  				data-tags="华为云"
  				data-name="华为云 DDS"
  				data-summary="采集华为云 DDS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dds/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DDS" class="fth-integration-name">华为云 DDS</div>
                            <div title="采集华为云 DDS 指标数据" class="fth-integration-desc">采集华为云 DDS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_dis"
  				data-tags="华为云"
  				data-name="华为云 DIS"
  				data-summary="采集华为云 DIS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DIS" class="fth-integration-name">华为云 DIS</div>
                            <div title="采集华为云 DIS 指标数据" class="fth-integration-desc">采集华为云 DIS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_ecs"
  				data-tags="华为云"
  				data-name="华为云 ECS"
  				data-summary="采集 华为云 ECS 监控指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 ECS" class="fth-integration-name">华为云 ECS</div>
                            <div title="采集 华为云 ECS 监控指标" class="fth-integration-desc">采集 华为云 ECS 监控指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_eip"
  				data-tags="华为云"
  				data-name="华为云 EIP"
  				data-summary="采集华为云 EIP 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 EIP" class="fth-integration-name">华为云 EIP</div>
                            <div title="采集华为云 EIP 指标数据" class="fth-integration-desc">采集华为云 EIP 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_elb"
  				data-tags="华为云"
  				data-name="华为云 ELB"
  				data-summary="采集 华为云 ELB 监控指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 ELB" class="fth-integration-name">华为云 ELB</div>
                            <div title="采集 华为云 ELB 监控指标" class="fth-integration-desc">采集 华为云 ELB 监控指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_gaussdb_cassandra"
  				data-tags="华为云"
  				data-name="华为云 GaussDB-Cassandra"
  				data-summary="华为云GaussDB-Cassandra的展示指标包括读写吞吐量、延迟、数据一致性和可扩展性，这些指标反映了GaussDB-Cassandra在处理大规模分布式数据存储和访问时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 GaussDB-Cassandra" class="fth-integration-name">华为云 GaussDB-Cassandra</div>
                            <div title="华为云GaussDB-Cassandra的展示指标包括读写吞吐量、延迟、数据一致性和可扩展性，这些指标反映了GaussDB-Cassandra在处理大规模分布式数据存储和访问时的性能表现和可靠性。" class="fth-integration-desc">华为云GaussDB-Cassandra的展示指标包括读写吞吐量、延迟、数据一致性和可扩展性，这些指标反映了GaussDB-Cassandra在处理大规模分布式数据存储和访问时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_gaussdb_for_mysql"
  				data-tags="华为云"
  				data-name="华为云 GaussDB for MySQL"
  				data-summary="GaussDB for MySQL，包括cpu、内存、网络、缓冲池、存储、慢日志、`innoDB`等相关指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_for_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 GaussDB for MySQL" class="fth-integration-name">华为云 GaussDB for MySQL</div>
                            <div title="GaussDB for MySQL，包括cpu、内存、网络、缓冲池、存储、慢日志、`innoDB`等相关指标。" class="fth-integration-desc">GaussDB for MySQL，包括cpu、内存、网络、缓冲池、存储、慢日志、`innoDB`等相关指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_gaussdb_influx"
  				data-tags="华为云"
  				data-name="华为云 GaussDB-Influx"
  				data-summary="华为云GaussDB-Influx的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了GaussDB-Influx在处理大规模时序数据存储和查询时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_influx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 GaussDB-Influx" class="fth-integration-name">华为云 GaussDB-Influx</div>
                            <div title="华为云GaussDB-Influx的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了GaussDB-Influx在处理大规模时序数据存储和查询时的性能表现和可靠性。" class="fth-integration-desc">华为云GaussDB-Influx的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了GaussDB-Influx在处理大规模时序数据存储和查询时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_gaussdb_redis"
  				data-tags="华为云"
  				data-name="华为云 GaussDB-Redis"
  				data-summary="华为云GaussDB-Redis的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了GaussDB-Redis在处理高并发数据存储和缓存时的性能表现和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 GaussDB-Redis" class="fth-integration-name">华为云 GaussDB-Redis</div>
                            <div title="华为云GaussDB-Redis的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了GaussDB-Redis在处理高并发数据存储和缓存时的性能表现和可靠性。" class="fth-integration-desc">华为云GaussDB-Redis的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了GaussDB-Redis在处理高并发数据存储和缓存时的性能表现和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_gaussdb_sys.gaussdbv5"
  				data-tags="华为云"
  				data-name="华为云 GaussDB SYS.GAUSSDBV5"
  				data-summary="华为云 GaussDB SYS.GAUSSDBV5，提供cpu、内存、磁盘、死锁、SQL 响应时间指标等数据。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_sys.gaussdbv5/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 GaussDB SYS.GAUSSDBV5" class="fth-integration-name">华为云 GaussDB SYS.GAUSSDBV5</div>
                            <div title="华为云 GaussDB SYS.GAUSSDBV5，提供cpu、内存、磁盘、死锁、SQL 响应时间指标等数据。" class="fth-integration-desc">华为云 GaussDB SYS.GAUSSDBV5，提供cpu、内存、磁盘、死锁、SQL 响应时间指标等数据。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_kafka"
  				data-tags="华为云"
  				data-name="华为云 DMS Kafka"
  				data-summary="采集华为云 DMS Kafka 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DMS Kafka" class="fth-integration-name">华为云 DMS Kafka</div>
                            <div title="采集华为云 DMS Kafka 指标数据" class="fth-integration-desc">采集华为云 DMS Kafka 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_mongodb"
  				data-tags="华为云"
  				data-name="华为云 MongoDB"
  				data-summary="采集华为云 MongoDB 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 MongoDB" class="fth-integration-name">华为云 MongoDB</div>
                            <div title="采集华为云 MongoDB 指标数据" class="fth-integration-desc">采集华为云 MongoDB 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_obs"
  				data-tags="华为云"
  				data-name="华为云 OBS"
  				data-summary="采集华为云 OBS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_obs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 OBS" class="fth-integration-name">华为云 OBS</div>
                            <div title="采集华为云 OBS 指标数据" class="fth-integration-desc">采集华为云 OBS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rabbitmq"
  				data-tags="华为云"
  				data-name="华为云 DMS RabbitMQ"
  				data-summary="采集 华为云 DMS RabbitMQ 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DMS RabbitMQ" class="fth-integration-name">华为云 DMS RabbitMQ</div>
                            <div title="采集 华为云 DMS RabbitMQ 指标数据" class="fth-integration-desc">采集 华为云 DMS RabbitMQ 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rds_mariadb"
  				data-tags="华为云"
  				data-name="华为云 RDS MariaDB"
  				data-summary="采集华为云 RDS MariaDB 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 RDS MariaDB" class="fth-integration-name">华为云 RDS MariaDB</div>
                            <div title="采集华为云 RDS MariaDB 指标数据" class="fth-integration-desc">采集华为云 RDS MariaDB 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rds_mysql"
  				data-tags="华为云"
  				data-name="华为云 RDS MYSQL"
  				data-summary="采集华为云 RDS MYSQL数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 RDS MYSQL" class="fth-integration-name">华为云 RDS MYSQL</div>
                            <div title="采集华为云 RDS MYSQL数据" class="fth-integration-desc">采集华为云 RDS MYSQL数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rds_postgresql"
  				data-tags="华为云"
  				data-name="华为云 RDS PostgreSQL"
  				data-summary="采集 华为云 RDS PostgreSQL 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 RDS PostgreSQL" class="fth-integration-name">华为云 RDS PostgreSQL</div>
                            <div title="采集 华为云 RDS PostgreSQL 指标数据" class="fth-integration-desc">采集 华为云 RDS PostgreSQL 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rds_sqlserver"
  				data-tags="华为云"
  				data-name="华为云 RDS SQLServer"
  				data-summary="采集华为云 RDS SQLServer 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 RDS SQLServer" class="fth-integration-name">华为云 RDS SQLServer</div>
                            <div title="采集华为云 RDS SQLServer 指标数据" class="fth-integration-desc">采集华为云 RDS SQLServer 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_rocketmq"
  				data-tags="华为云"
  				data-name="华为云 DMS RocketMQ"
  				data-summary="采集 华为云 DMS RocketMQ 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 DMS RocketMQ" class="fth-integration-name">华为云 DMS RocketMQ</div>
                            <div title="采集 华为云 DMS RocketMQ 指标数据" class="fth-integration-desc">采集 华为云 DMS RocketMQ 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_roma"
  				data-tags="华为云"
  				data-name="华为云 ROMA"
  				data-summary="采集 华为云 ROMA 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_roma/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 ROMA" class="fth-integration-name">华为云 ROMA</div>
                            <div title="采集 华为云 ROMA 指标数据" class="fth-integration-desc">采集 华为云 ROMA 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huawei_waf"
  				data-tags="华为云"
  				data-name="华为云 WAF Web应用防火墙"
  				data-summary="采集华为云 WAF 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_waf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="华为云 WAF Web应用防火墙" class="fth-integration-name">华为云 WAF Web应用防火墙</div>
                            <div title="采集华为云 WAF 指标数据" class="fth-integration-desc">采集华为云 WAF 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../iis"
  				data-tags="WINDOWS,IIS,WEB SERVER"
  				data-name="IIS"
  				data-summary="采集 IIS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/iis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="IIS" class="fth-integration-name">IIS</div>
                            <div title="采集 IIS 指标数据" class="fth-integration-desc">采集 IIS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ilogtail"
  				data-tags=""
  				data-name="iLogtail"
  				data-summary="iLogtail 采集日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ilogtail/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="iLogtail" class="fth-integration-name">iLogtail</div>
                            <div title="iLogtail 采集日志信息" class="fth-integration-desc">iLogtail 采集日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../influxdb"
  				data-tags="数据库"
  				data-name="InfluxDB"
  				data-summary="采集 InfluxDB 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/influxdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="InfluxDB" class="fth-integration-name">InfluxDB</div>
                            <div title="采集 InfluxDB 指标数据" class="fth-integration-desc">采集 InfluxDB 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ingress-nginx-prom"
  				data-tags=""
  				data-name="Ingress Nginx (Prometheus)"
  				data-summary="采集 Ingress Nginx (Prometheus) 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ingress/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Ingress Nginx (Prometheus)" class="fth-integration-name">Ingress Nginx (Prometheus)</div>
                            <div title="采集 Ingress Nginx (Prometheus) 相关指标信息" class="fth-integration-desc">采集 Ingress Nginx (Prometheus) 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ipmi"
  				data-tags="IPMI"
  				data-name="IPMI"
  				data-summary="IPMI 指标展示被监测设备的电流、电压、功耗、占用率、风扇转速、温度以及设备状态等信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ipmi/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="IPMI" class="fth-integration-name">IPMI</div>
                            <div title="IPMI 指标展示被监测设备的电流、电压、功耗、占用率、风扇转速、温度以及设备状态等信息" class="fth-integration-desc">IPMI 指标展示被监测设备的电流、电压、功耗、占用率、风扇转速、温度以及设备状态等信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../issue_dingtalk"
  				data-tags=""
  				data-name="异常追踪 - 钉钉"
  				data-summary="<<< custom_key.brand_name >>>异常追踪与钉钉深度集成，方便将异常追踪信息发送给钉钉，通过钉钉进行回复并回传到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dingtalk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="异常追踪 - 钉钉" class="fth-integration-name">异常追踪 - 钉钉</div>
                            <div title="<<< custom_key.brand_name >>>异常追踪与钉钉深度集成，方便将异常追踪信息发送给钉钉，通过钉钉进行回复并回传到<<< custom_key.brand_name >>>" class="fth-integration-desc"><<< custom_key.brand_name >>>异常追踪与钉钉深度集成，方便将异常追踪信息发送给钉钉，通过钉钉进行回复并回传到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../issue_feishu"
  				data-tags=""
  				data-name="异常追踪 - 飞书"
  				data-summary="<<< custom_key.brand_name >>>异常追踪与飞书深度集成，方便将异常追踪信息发送给飞书，通过飞书进行回复并回传到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/feishu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="异常追踪 - 飞书" class="fth-integration-name">异常追踪 - 飞书</div>
                            <div title="<<< custom_key.brand_name >>>异常追踪与飞书深度集成，方便将异常追踪信息发送给飞书，通过飞书进行回复并回传到<<< custom_key.brand_name >>>" class="fth-integration-desc"><<< custom_key.brand_name >>>异常追踪与飞书深度集成，方便将异常追踪信息发送给飞书，通过飞书进行回复并回传到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../istio"
  				data-tags=""
  				data-name="Istio"
  				data-summary="Istio 性能指标展示，包括 Incoming Request Volume、Incoming Success Rate、Incoming Requests By Source And Response Code、Outgoing Requests By Destination And Response Code 等"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Istio" class="fth-integration-name">Istio</div>
                            <div title="Istio 性能指标展示，包括 Incoming Request Volume、Incoming Success Rate、Incoming Requests By Source And Response Code、Outgoing Requests By Destination And Response Code 等" class="fth-integration-desc">Istio 性能指标展示，包括 Incoming Request Volume、Incoming Success Rate、Incoming Requests By Source And Response Code、Outgoing Requests By Destination And Response Code 等</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jaeger"
  				data-tags="JAEGER,链路追踪"
  				data-name="Jaeger"
  				data-summary="接收 Jaeger APM 数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jaeger/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Jaeger" class="fth-integration-name">Jaeger</div>
                            <div title="接收 Jaeger APM 数据" class="fth-integration-desc">接收 Jaeger APM 数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../java"
  				data-tags=""
  				data-name="JAVA"
  				data-summary="获取 JAVA 应用的指标、链路追踪和日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JAVA" class="fth-integration-name">JAVA</div>
                            <div title="获取 JAVA 应用的指标、链路追踪和日志信息" class="fth-integration-desc">获取 JAVA 应用的指标、链路追踪和日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../javascript"
  				data-tags=""
  				data-name="JavaScript"
  				data-summary="通过 JavaScript (Web) 方式监测浏览器用户的使用行为"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/javascript/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JavaScript" class="fth-integration-name">JavaScript</div>
                            <div title="通过 JavaScript (Web) 方式监测浏览器用户的使用行为" class="fth-integration-desc">通过 JavaScript (Web) 方式监测浏览器用户的使用行为</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jenkins"
  				data-tags="JENKINS,CI/CD"
  				data-name="Jenkins"
  				data-summary="采集 Jenkins 的指标和日志"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jenkins/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Jenkins" class="fth-integration-name">Jenkins</div>
                            <div title="采集 Jenkins 的指标和日志" class="fth-integration-desc">采集 Jenkins 的指标和日志</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jmx"
  				data-tags=""
  				data-name="JMX"
  				data-summary="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JMX" class="fth-integration-name">JMX</div>
                            <div title="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。" class="fth-integration-desc">JVM 性能指标展示：堆与非堆内存、线程、类加载数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../juicefs"
  				data-tags=""
  				data-name="JuiceFS"
  				data-summary="采集 JuiceFS 数据大小、IO、事物、对象、客户端等相关组件指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/juicefs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JuiceFS" class="fth-integration-name">JuiceFS</div>
                            <div title="采集 JuiceFS 数据大小、IO、事物、对象、客户端等相关组件指标信息" class="fth-integration-desc">采集 JuiceFS 数据大小、IO、事物、对象、客户端等相关组件指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jvm"
  				data-tags="JAVA"
  				data-name="JVM"
  				data-summary="采集 JVM 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JVM" class="fth-integration-name">JVM</div>
                            <div title="采集 JVM 的指标数据" class="fth-integration-desc">采集 JVM 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jvm_jmx_exporter"
  				data-tags=""
  				data-name="JMX Exporter"
  				data-summary="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JMX Exporter" class="fth-integration-name">JMX Exporter</div>
                            <div title="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。" class="fth-integration-desc">JVM 性能指标展示：堆与非堆内存、线程、类加载数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jvm_jolokia"
  				data-tags=""
  				data-name="JMX Jolokia"
  				data-summary="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JMX Jolokia" class="fth-integration-name">JMX Jolokia</div>
                            <div title="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。" class="fth-integration-desc">JVM 性能指标展示：堆与非堆内存、线程、类加载数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jvm_micrometer"
  				data-tags=""
  				data-name="JMX Micrometer"
  				data-summary="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JMX Micrometer" class="fth-integration-name">JMX Micrometer</div>
                            <div title="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。" class="fth-integration-desc">JVM 性能指标展示：堆与非堆内存、线程、类加载数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../jvm_statsd"
  				data-tags=""
  				data-name="JMX StatsD"
  				data-summary="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="JMX StatsD" class="fth-integration-name">JMX StatsD</div>
                            <div title="JVM 性能指标展示：堆与非堆内存、线程、类加载数等。" class="fth-integration-desc">JVM 性能指标展示：堆与非堆内存、线程、类加载数等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kafka"
  				data-tags="中间件,消息队列"
  				data-name="Kafka"
  				data-summary="采集 Kafka 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kafka" class="fth-integration-name">Kafka</div>
                            <div title="采集 Kafka 的指标数据" class="fth-integration-desc">采集 Kafka 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kafkamq"
  				data-tags="消息队列,日志"
  				data-name="KafkaMQ"
  				data-summary="通过 Kafka 收集已有的指标和日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="KafkaMQ" class="fth-integration-name">KafkaMQ</div>
                            <div title="通过 Kafka 收集已有的指标和日志数据" class="fth-integration-desc">通过 Kafka 收集已有的指标和日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kong"
  				data-tags=""
  				data-name="Kong"
  				data-summary="采集 Kong 指标、日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kong" class="fth-integration-name">Kong</div>
                            <div title="采集 Kong 指标、日志信息" class="fth-integration-desc">采集 Kong 指标、日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kube_proxy"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="kube Proxy"
  				data-summary="通过跟踪 kube-proxy 运行指标,帮助了解网络代理的负载、响应时间、同步状态等信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_proxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="kube Proxy" class="fth-integration-name">kube Proxy</div>
                            <div title="通过跟踪 kube-proxy 运行指标,帮助了解网络代理的负载、响应时间、同步状态等信息" class="fth-integration-desc">通过跟踪 kube-proxy 运行指标,帮助了解网络代理的负载、响应时间、同步状态等信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kube_scheduler"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kube Scheduler"
  				data-summary="通过监控 Kube Scheduler 指标,帮助配置和优化Kube Scheduler，可以提高集群的资源利用率和应用程序的性能"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_scheduler/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kube Scheduler" class="fth-integration-name">Kube Scheduler</div>
                            <div title="通过监控 Kube Scheduler 指标,帮助配置和优化Kube Scheduler，可以提高集群的资源利用率和应用程序的性能" class="fth-integration-desc">通过监控 Kube Scheduler 指标,帮助配置和优化Kube Scheduler，可以提高集群的资源利用率和应用程序的性能</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kube_state_metrics"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kube State Metrics"
  				data-summary="通过 Kube State Metrics 收集集群资源实时信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_state_metrics/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kube State Metrics" class="fth-integration-name">Kube State Metrics</div>
                            <div title="通过 Kube State Metrics 收集集群资源实时信息" class="fth-integration-desc">通过 Kube State Metrics 收集集群资源实时信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubecost"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="KubeCost"
  				data-summary="采集 KubeCost 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubecost/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="KubeCost" class="fth-integration-name">KubeCost</div>
                            <div title="采集 KubeCost 指标信息" class="fth-integration-desc">采集 KubeCost 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubelet"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubelet"
  				data-summary="采集 Kubelet 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubelet/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubelet" class="fth-integration-name">Kubelet</div>
                            <div title="采集 Kubelet 指标信息" class="fth-integration-desc">采集 Kubelet 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetes-api-server"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes API Server"
  				data-summary="采集 Kubernetes API Server 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes API Server" class="fth-integration-name">Kubernetes API Server</div>
                            <div title="采集 Kubernetes API Server 相关指标信息" class="fth-integration-desc">采集 Kubernetes API Server 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetes-crd"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes CRD"
  				data-summary="Create Datakit CRD to collect"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes CRD" class="fth-integration-name">Kubernetes CRD</div>
                            <div title="Create Datakit CRD to collect" class="fth-integration-desc">Create Datakit CRD to collect</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetes-prom"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes Prometheus Exporter"
  				data-summary="采集 Kubernetes 集群中自定义 Pod 暴露出来的 Prometheus 指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes Prometheus Exporter" class="fth-integration-name">Kubernetes Prometheus Exporter</div>
                            <div title="采集 Kubernetes 集群中自定义 Pod 暴露出来的 Prometheus 指标" class="fth-integration-desc">采集 Kubernetes 集群中自定义 Pod 暴露出来的 Prometheus 指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetes-prometheus-operator-crd"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Prometheus CRD"
  				data-summary="支持 Prometheus-Operator CRD 并采集对应指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Prometheus CRD" class="fth-integration-name">Prometheus CRD</div>
                            <div title="支持 Prometheus-Operator CRD 并采集对应指标" class="fth-integration-desc">支持 Prometheus-Operator CRD 并采集对应指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetes_audit"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes 审计日志采集"
  				data-summary="Kubernetes 审计日志采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes 审计日志采集" class="fth-integration-name">Kubernetes 审计日志采集</div>
                            <div title="Kubernetes 审计日志采集" class="fth-integration-desc">Kubernetes 审计日志采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../kubernetesprometheus"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes Prometheus Discovery"
  				data-summary="支持发现 Kubernetes 中的 Prometheus 指标暴露并采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes Prometheus Discovery" class="fth-integration-name">Kubernetes Prometheus Discovery</div>
                            <div title="支持发现 Kubernetes 中的 Prometheus 指标暴露并采集" class="fth-integration-desc">支持发现 Kubernetes 中的 Prometheus 指标暴露并采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../langchain"
  				data-tags=""
  				data-name="LangChain"
  				data-summary="优化 LangChain 的使用：及时采样以及性能和成本指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/langchain/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="LangChain" class="fth-integration-name">LangChain</div>
                            <div title="优化 LangChain 的使用：及时采样以及性能和成本指标。" class="fth-integration-desc">优化 LangChain 的使用：及时采样以及性能和成本指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logfwd"
  				data-tags="KUBERNETES,日志,容器"
  				data-name="Log Sidecar"
  				data-summary="Sidecar 形式的日志采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Log Sidecar" class="fth-integration-name">Log Sidecar</div>
                            <div title="Sidecar 形式的日志采集" class="fth-integration-desc">Sidecar 形式的日志采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logfwdserver"
  				data-tags="KUBERNETES,日志,容器"
  				data-name="Log Forward"
  				data-summary="通过 sidecar 方式收集 Pod 内日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logfwd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Log Forward" class="fth-integration-name">Log Forward</div>
                            <div title="通过 sidecar 方式收集 Pod 内日志数据" class="fth-integration-desc">通过 sidecar 方式收集 Pod 内日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logging"
  				data-tags="日志"
  				data-name="日志采集"
  				data-summary="采集主机上的日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logging/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="日志采集" class="fth-integration-name">日志采集</div>
                            <div title="采集主机上的日志数据" class="fth-integration-desc">采集主机上的日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logging_socket"
  				data-tags="日志"
  				data-name="Socket Logging"
  				data-summary="主要用于 Java/Go/Python 日志框架如何配置 Socket，将日志发送给 Datakit 日志采集器中。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/socket/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Socket Logging" class="fth-integration-name">Socket Logging</div>
                            <div title="主要用于 Java/Go/Python 日志框架如何配置 Socket，将日志发送给 Datakit 日志采集器中。" class="fth-integration-desc">主要用于 Java/Go/Python 日志框架如何配置 Socket，将日志发送给 Datakit 日志采集器中。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logstash"
  				data-tags=""
  				data-name="Logstash"
  				data-summary="通过 Logstash 采集日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logstash/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Logstash" class="fth-integration-name">Logstash</div>
                            <div title="通过 Logstash 采集日志信息" class="fth-integration-desc">通过 Logstash 采集日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../logstreaming"
  				data-tags="日志"
  				data-name="Log Streaming"
  				data-summary="通过 HTTP 上报日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logstreaming/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Log Streaming" class="fth-integration-name">Log Streaming</div>
                            <div title="通过 HTTP 上报日志数据" class="fth-integration-desc">通过 HTTP 上报日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../lsblk"
  				data-tags="主机"
  				data-name="Lsblk"
  				data-summary="采集块设备的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/disk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Lsblk" class="fth-integration-name">Lsblk</div>
                            <div title="采集块设备的指标数据" class="fth-integration-desc">采集块设备的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../mem"
  				data-tags="主机"
  				data-name="内存"
  				data-summary="采集主机内存的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="内存" class="fth-integration-name">内存</div>
                            <div title="采集主机内存的指标数据" class="fth-integration-desc">采集主机内存的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../memcached"
  				data-tags="缓存,中间件"
  				data-name="Memcached"
  				data-summary="采集 Memcached 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Memcached" class="fth-integration-name">Memcached</div>
                            <div title="采集 Memcached 的指标数据" class="fth-integration-desc">采集 Memcached 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../milvus"
  				data-tags=""
  				data-name="Milvus 向量数据库"
  				data-summary="采集 Mlivus 向量数据库相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/milvus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Milvus 向量数据库" class="fth-integration-name">Milvus 向量数据库</div>
                            <div title="采集 Mlivus 向量数据库相关指标信息" class="fth-integration-desc">采集 Mlivus 向量数据库相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../minio"
  				data-tags=""
  				data-name="MinIO"
  				data-summary="采集 MinIO 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/minio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="MinIO" class="fth-integration-name">MinIO</div>
                            <div title="采集 MinIO 相关指标信息" class="fth-integration-desc">采集 MinIO 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../minio_v3"
  				data-tags=""
  				data-name="MinIO V3"
  				data-summary="采集 MinIO 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/minio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="MinIO V3" class="fth-integration-name">MinIO V3</div>
                            <div title="采集 MinIO 相关指标信息" class="fth-integration-desc">采集 MinIO 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../mongodb"
  				data-tags="数据库"
  				data-name="MongoDB"
  				data-summary="采集 MongoDB 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="MongoDB" class="fth-integration-name">MongoDB</div>
                            <div title="采集 MongoDB 的指标数据" class="fth-integration-desc">采集 MongoDB 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../monitor_jira"
  				data-tags=""
  				data-name="异常事件与 Jira 联动"
  				data-summary="当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 Jira 中创建事件，这样我们就可以在 Jira 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 Jira 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/monitor_jira/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="异常事件与 Jira 联动" class="fth-integration-name">异常事件与 Jira 联动</div>
                            <div title="当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 Jira 中创建事件，这样我们就可以在 Jira 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 Jira 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。" class="fth-integration-desc">当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 Jira 中创建事件，这样我们就可以在 Jira 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 Jira 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../mqtt"
  				data-tags=""
  				data-name="MQTT"
  				data-summary="接收 MQTT 协议数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mqtt/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="MQTT" class="fth-integration-name">MQTT</div>
                            <div title="接收 MQTT 协议数据" class="fth-integration-desc">接收 MQTT 协议数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../mysql"
  				data-tags="数据库"
  				data-name="MySQL"
  				data-summary="采集 MySQL 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="MySQL" class="fth-integration-name">MySQL</div>
                            <div title="采集 MySQL 的指标数据" class="fth-integration-desc">采集 MySQL 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nacos"
  				data-tags=""
  				data-name="Nacos"
  				data-summary="采集 Nacos 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nacos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Nacos" class="fth-integration-name">Nacos</div>
                            <div title="采集 Nacos 相关指标信息" class="fth-integration-desc">采集 Nacos 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../neo4j"
  				data-tags="数据库"
  				data-name="Neo4j"
  				data-summary="采集 Neo4j 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/neo4j/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Neo4j" class="fth-integration-name">Neo4j</div>
                            <div title="采集 Neo4j 的指标数据" class="fth-integration-desc">采集 Neo4j 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../net"
  				data-tags="主机,网络"
  				data-name="Net"
  				data-summary="采集网卡的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/net/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Net" class="fth-integration-name">Net</div>
                            <div title="采集网卡的指标数据" class="fth-integration-desc">采集网卡的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../netflow"
  				data-tags="网络"
  				data-name="NetFlow"
  				data-summary="NetFlow 采集器可以用来可视化和监控已开启 NetFlow 的设备"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/netflow/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="NetFlow" class="fth-integration-name">NetFlow</div>
                            <div title="NetFlow 采集器可以用来可视化和监控已开启 NetFlow 的设备" class="fth-integration-desc">NetFlow 采集器可以用来可视化和监控已开启 NetFlow 的设备</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../netstat"
  				data-tags="网络,主机"
  				data-name="NetStat"
  				data-summary="采集网卡流量指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/netstat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="NetStat" class="fth-integration-name">NetStat</div>
                            <div title="采集网卡流量指标数据" class="fth-integration-desc">采集网卡流量指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../newrelic"
  				data-tags="NEWRELIC,链路追踪"
  				data-name="New Relic"
  				data-summary="接收来自 New Relic Agent 的数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="New Relic" class="fth-integration-name">New Relic</div>
                            <div title="接收来自 New Relic Agent 的数据" class="fth-integration-desc">接收来自 New Relic Agent 的数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nfs"
  				data-tags="主机"
  				data-name="NFS"
  				data-summary="NFS 指标采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nfs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="NFS" class="fth-integration-name">NFS</div>
                            <div title="NFS 指标采集" class="fth-integration-desc">NFS 指标采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nginx"
  				data-tags="WEB SERVER,中间件"
  				data-name="Nginx"
  				data-summary="采集 Nginx 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nginx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Nginx" class="fth-integration-name">Nginx</div>
                            <div title="采集 Nginx 的指标数据" class="fth-integration-desc">采集 Nginx 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nginx_tracing"
  				data-tags=""
  				data-name="Nginx Tracing"
  				data-summary="采集 Nginx 链路信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nginx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Nginx Tracing" class="fth-integration-name">Nginx Tracing</div>
                            <div title="采集 Nginx 链路信息" class="fth-integration-desc">采集 Nginx 链路信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../node-exporter"
  				data-tags=""
  				data-name="Node Exporter"
  				data-summary="通过 Node Exporter 采集主机指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/node_exporter/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Node Exporter" class="fth-integration-name">Node Exporter</div>
                            <div title="通过 Node Exporter 采集主机指标信息" class="fth-integration-desc">通过 Node Exporter 采集主机指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nodejs"
  				data-tags=""
  				data-name="NodeJs"
  				data-summary="获取 NodeJs 应用的指标、链路追踪和日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nodejs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="NodeJs" class="fth-integration-name">NodeJs</div>
                            <div title="获取 NodeJs 应用的指标、链路追踪和日志信息" class="fth-integration-desc">获取 NodeJs 应用的指标、链路追踪和日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../npd"
  				data-tags=""
  				data-name="Node Problem Detector"
  				data-summary="通过 NPD 采集集群节点指标、事件"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Node Problem Detector" class="fth-integration-name">Node Problem Detector</div>
                            <div title="通过 NPD 采集集群节点指标、事件" class="fth-integration-desc">通过 NPD 采集集群节点指标、事件</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../nsq"
  				data-tags="消息队列,中间件"
  				data-name="NSQ"
  				data-summary="采集 NSQ 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nsq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="NSQ" class="fth-integration-name">NSQ</div>
                            <div title="采集 NSQ 的指标数据" class="fth-integration-desc">采集 NSQ 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../oceanbase"
  				data-tags="数据库"
  				data-name="OceanBase"
  				data-summary="采集 OceanBase 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/oceanbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OceanBase" class="fth-integration-name">OceanBase</div>
                            <div title="采集 OceanBase 的指标数据" class="fth-integration-desc">采集 OceanBase 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../openai"
  				data-tags=""
  				data-name="OpenAI"
  				data-summary="OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/openai/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenAI" class="fth-integration-name">OpenAI</div>
                            <div title="OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。" class="fth-integration-desc">OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../opengauss"
  				data-tags=""
  				data-name="OpenGauss"
  				data-summary="采集 OpenGauss 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opengauss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenGauss" class="fth-integration-name">OpenGauss</div>
                            <div title="采集 OpenGauss 指标信息" class="fth-integration-desc">采集 OpenGauss 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../openlit"
  				data-tags="OTEL,链路追踪"
  				data-name="OpenLIT"
  				data-summary="OpenLIT 通过简化生成式 AI 和大模型语言(LLM)的开发流程，并提供全面的可观测性支持，并将可观测性数据上报到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/openlit/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenLIT" class="fth-integration-name">OpenLIT</div>
                            <div title="OpenLIT 通过简化生成式 AI 和大模型语言(LLM)的开发流程，并提供全面的可观测性支持，并将可观测性数据上报到<<< custom_key.brand_name >>>" class="fth-integration-desc">OpenLIT 通过简化生成式 AI 和大模型语言(LLM)的开发流程，并提供全面的可观测性支持，并将可观测性数据上报到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../opentelemetry-go"
  				data-tags="GOLANG,OTEL,链路追踪"
  				data-name="OpenTelemetry Golang"
  				data-summary="OpenTelemetry Golang 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry Golang" class="fth-integration-name">OpenTelemetry Golang</div>
                            <div title="OpenTelemetry Golang 集成" class="fth-integration-desc">OpenTelemetry Golang 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../opentelemetry-java"
  				data-tags="JAVA,OTEL,链路追踪"
  				data-name="OpenTelemetry Java"
  				data-summary="OpenTelemetry Java 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry Java" class="fth-integration-name">OpenTelemetry Java</div>
                            <div title="OpenTelemetry Java 集成" class="fth-integration-desc">OpenTelemetry Java 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../opentelemetry-python"
  				data-tags="PYTHON,OTEL,链路追踪"
  				data-name="OpenTelemetry Python"
  				data-summary="OpenTelemetry Python 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry Python" class="fth-integration-name">OpenTelemetry Python</div>
                            <div title="OpenTelemetry Python 集成" class="fth-integration-desc">OpenTelemetry Python 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../opentelemetry"
  				data-tags="OTEL,链路追踪"
  				data-name="OpenTelemetry"
  				data-summary="接收 OpenTelemetry 指标、日志、APM 数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry" class="fth-integration-name">OpenTelemetry</div>
                            <div title="接收 OpenTelemetry 指标、日志、APM 数据" class="fth-integration-desc">接收 OpenTelemetry 指标、日志、APM 数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../oracle"
  				data-tags="数据库"
  				data-name="Oracle"
  				data-summary="采集 Oracle 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/oracle/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Oracle" class="fth-integration-name">Oracle</div>
                            <div title="采集 Oracle 的指标数据" class="fth-integration-desc">采集 Oracle 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../otel-ext-java"
  				data-tags="OTEL,链路追踪"
  				data-name="OpenTelemetry 扩展"
  				data-summary="<<<custom_key.brand_name>>>对 OpenTelemetry 插件做了额外的扩展"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry 扩展" class="fth-integration-name">OpenTelemetry 扩展</div>
                            <div title="<<<custom_key.brand_name>>>对 OpenTelemetry 插件做了额外的扩展" class="fth-integration-desc"><<<custom_key.brand_name>>>对 OpenTelemetry 插件做了额外的扩展</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../otel-guance-exporter"
  				data-tags="OTEL"
  				data-name="<<<custom_key.brand_name>>> OpenTelemetry Exportor"
  				data-summary="直接将 OpenTelemetry 的数据输出给<<<custom_key.brand_name>>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="<<<custom_key.brand_name>>> OpenTelemetry Exportor" class="fth-integration-name"><<<custom_key.brand_name>>> OpenTelemetry Exportor</div>
                            <div title="直接将 OpenTelemetry 的数据输出给<<<custom_key.brand_name>>>" class="fth-integration-desc">直接将 OpenTelemetry 的数据输出给<<<custom_key.brand_name>>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pagerduty"
  				data-tags=""
  				data-name="异常事件与 PagerDuty 联动"
  				data-summary="当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pagerduty/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="异常事件与 PagerDuty 联动" class="fth-integration-name">异常事件与 PagerDuty 联动</div>
                            <div title="当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。" class="fth-integration-desc">当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../php"
  				data-tags=""
  				data-name="PHP"
  				data-summary="获取 PHP 应用的指标、链路追踪和日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/php/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="PHP" class="fth-integration-name">PHP</div>
                            <div title="获取 PHP 应用的指标、链路追踪和日志信息" class="fth-integration-desc">获取 PHP 应用的指标、链路追踪和日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pinpoint-go"
  				data-tags="PINPOINT,GOLANG,链路追踪"
  				data-name="PinPoint Golang"
  				data-summary="PinPoint Golang 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="PinPoint Golang" class="fth-integration-name">PinPoint Golang</div>
                            <div title="PinPoint Golang 集成" class="fth-integration-desc">PinPoint Golang 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pinpoint-java"
  				data-tags="PINPOINT,JAVA,链路追踪"
  				data-name="PinPoint Java"
  				data-summary="PinPoint Java 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="PinPoint Java" class="fth-integration-name">PinPoint Java</div>
                            <div title="PinPoint Java 集成" class="fth-integration-desc">PinPoint Java 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pinpoint"
  				data-tags="PINPOINT,链路追踪"
  				data-name="Pinpoint"
  				data-summary="Pinpoint Tracing 数据接入"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Pinpoint" class="fth-integration-name">Pinpoint</div>
                            <div title="Pinpoint Tracing 数据接入" class="fth-integration-desc">Pinpoint Tracing 数据接入</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ploffload"
  				data-tags="PIPELINE"
  				data-name="Pipeline Offload"
  				data-summary="接收来自 Datakit Pipeline 卸载的待处理数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ploffload/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Pipeline Offload" class="fth-integration-name">Pipeline Offload</div>
                            <div title="接收来自 Datakit Pipeline 卸载的待处理数据" class="fth-integration-desc">接收来自 Datakit Pipeline 卸载的待处理数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../postgresql"
  				data-tags="数据库"
  				data-name="PostgreSQL"
  				data-summary="采集 PostgreSQL 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="PostgreSQL" class="fth-integration-name">PostgreSQL</div>
                            <div title="采集 PostgreSQL 的指标数据" class="fth-integration-desc">采集 PostgreSQL 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-cpp"
  				data-tags="C/C++,PROFILE"
  				data-name="Profiling C++"
  				data-summary="C++ Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling C++" class="fth-integration-name">Profiling C++</div>
                            <div title="C++ Profiling 集成" class="fth-integration-desc">C++ Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-dotnet"
  				data-tags=".Net,PROFILE"
  				data-name="Profiling .Net"
  				data-summary=".Net Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling .Net" class="fth-integration-name">Profiling .Net</div>
                            <div title=".Net Profiling 集成" class="fth-integration-desc">.Net Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-go"
  				data-tags="GOLANG,PROFILE"
  				data-name="Profiling Golang"
  				data-summary="Golang Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling Golang" class="fth-integration-name">Profiling Golang</div>
                            <div title="Golang Profiling 集成" class="fth-integration-desc">Golang Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-java"
  				data-tags="JAVA,PROFILE"
  				data-name="Profiling Java"
  				data-summary="Java Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling Java" class="fth-integration-name">Profiling Java</div>
                            <div title="Java Profiling 集成" class="fth-integration-desc">Java Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-nodejs"
  				data-tags="NODEJS,PROFILE"
  				data-name="Profiling NodeJS"
  				data-summary="NodeJS Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling NodeJS" class="fth-integration-name">Profiling NodeJS</div>
                            <div title="NodeJS Profiling 集成" class="fth-integration-desc">NodeJS Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-php"
  				data-tags="PHP,PROFILE"
  				data-name="Profiling PHP"
  				data-summary="PHP Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling PHP" class="fth-integration-name">Profiling PHP</div>
                            <div title="PHP Profiling 集成" class="fth-integration-desc">PHP Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile-python"
  				data-tags="PYTHON,PROFILE"
  				data-name="Profiling Python"
  				data-summary="Python Profiling 集成"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling Python" class="fth-integration-name">Profiling Python</div>
                            <div title="Python Profiling 集成" class="fth-integration-desc">Python Profiling 集成</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../profile"
  				data-tags="PROFILE"
  				data-name="Profiling"
  				data-summary="采集应用程序的运行时性能数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Profiling" class="fth-integration-name">Profiling</div>
                            <div title="采集应用程序的运行时性能数据" class="fth-integration-desc">采集应用程序的运行时性能数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../prom"
  				data-tags="外部数据接入,PROMETHEUS"
  				data-name="Prometheus Exporter"
  				data-summary="采集 Prometheus Exporter 暴露的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/prometheus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Prometheus Exporter" class="fth-integration-name">Prometheus Exporter</div>
                            <div title="采集 Prometheus Exporter 暴露的指标数据" class="fth-integration-desc">采集 Prometheus Exporter 暴露的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../prom_remote_write"
  				data-tags="外部数据接入,PROMETHEUS"
  				data-name="Prometheus Remote Write"
  				data-summary="通过 Prometheus Remote Write 汇集指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/prometheus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Prometheus Remote Write" class="fth-integration-name">Prometheus Remote Write</div>
                            <div title="通过 Prometheus Remote Write 汇集指标数据" class="fth-integration-desc">通过 Prometheus Remote Write 汇集指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../promtail"
  				data-tags="外部数据接入"
  				data-name="Promtail"
  				data-summary="采集 Promtail 上报的日志数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/promtail/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Promtail" class="fth-integration-name">Promtail</div>
                            <div title="采集 Promtail 上报的日志数据" class="fth-integration-desc">采集 Promtail 上报的日志数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../proxy"
  				data-tags="PROXY"
  				data-name="Proxy"
  				data-summary="代理 Datakit 的 HTTP 请求"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/proxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Proxy" class="fth-integration-name">Proxy</div>
                            <div title="代理 Datakit 的 HTTP 请求" class="fth-integration-desc">代理 Datakit 的 HTTP 请求</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pushgateway"
  				data-tags="外部数据接入,PROMETHEUS"
  				data-name="Prometheus Push Gateway"
  				data-summary="开启 Pushgateway API，接收 Prometheus 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pushgateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Prometheus Push Gateway" class="fth-integration-name">Prometheus Push Gateway</div>
                            <div title="开启 Pushgateway API，接收 Prometheus 指标数据" class="fth-integration-desc">开启 Pushgateway API，接收 Prometheus 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pyroscope"
  				data-tags="PYROSCOPE,PROFILE"
  				data-name="Pyroscope"
  				data-summary="Grafana Pyroscope 应用程序性能采集器"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Pyroscope" class="fth-integration-name">Pyroscope</div>
                            <div title="Grafana Pyroscope 应用程序性能采集器" class="fth-integration-desc">Grafana Pyroscope 应用程序性能采集器</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../pythond"
  				data-tags="PYTHON"
  				data-name="Pythond"
  				data-summary="通过 Python 扩展采集数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pythond/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Pythond" class="fth-integration-name">Pythond</div>
                            <div title="通过 Python 扩展采集数据" class="fth-integration-desc">通过 Python 扩展采集数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../quick-guide"
  				data-tags=""
  				data-name="Grafana Dashboard Import"
  				data-summary="Grafana Dashboard 模版导入<<< custom_key.brand_name >>>工具"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/grafana_import/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Grafana Dashboard Import" class="fth-integration-name">Grafana Dashboard Import</div>
                            <div title="Grafana Dashboard 模版导入<<< custom_key.brand_name >>>工具" class="fth-integration-desc">Grafana Dashboard 模版导入<<< custom_key.brand_name >>>工具</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../rabbitmq"
  				data-tags="消息队列,中间件"
  				data-name="RabbitMQ"
  				data-summary="采集 RabbitMQ 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="RabbitMQ" class="fth-integration-name">RabbitMQ</div>
                            <div title="采集 RabbitMQ 的指标数据" class="fth-integration-desc">采集 RabbitMQ 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ranger_admin"
  				data-tags=""
  				data-name="Ranger Admin"
  				data-summary="采集 Ranger Admin 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ranger/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Ranger Admin" class="fth-integration-name">Ranger Admin</div>
                            <div title="采集 Ranger Admin 指标信息" class="fth-integration-desc">采集 Ranger Admin 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ranger_tagsync"
  				data-tags=""
  				data-name="Ranger Tagsync"
  				data-summary="采集 Ranger Tagsync 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ranger/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Ranger Tagsync" class="fth-integration-name">Ranger Tagsync</div>
                            <div title="采集 Ranger Tagsync 指标信息" class="fth-integration-desc">采集 Ranger Tagsync 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ranger_usersync"
  				data-tags=""
  				data-name="Ranger Usersync"
  				data-summary="采集 Ranger Usersync 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ranger/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Ranger Usersync" class="fth-integration-name">Ranger Usersync</div>
                            <div title="采集 Ranger Usersync 指标信息" class="fth-integration-desc">采集 Ranger Usersync 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../redis-sentinel"
  				data-tags=""
  				data-name="Redis Sentinel"
  				data-summary="采集 Redis Sentinel 集群指标、日志信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Redis Sentinel" class="fth-integration-name">Redis Sentinel</div>
                            <div title="采集 Redis Sentinel 集群指标、日志信息" class="fth-integration-desc">采集 Redis Sentinel 集群指标、日志信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../redis"
  				data-tags="缓存,中间件"
  				data-name="Redis"
  				data-summary="Redis 指标和日志采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Redis" class="fth-integration-name">Redis</div>
                            <div title="Redis 指标和日志采集" class="fth-integration-desc">Redis 指标和日志采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../resin"
  				data-tags=""
  				data-name="Resin"
  				data-summary="Resin 性能指标展示，包括启动时间、堆内存、非堆内存、类、线程等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/resin/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Resin" class="fth-integration-name">Resin</div>
                            <div title="Resin 性能指标展示，包括启动时间、堆内存、非堆内存、类、线程等。" class="fth-integration-desc">Resin 性能指标展示，包括启动时间、堆内存、非堆内存、类、线程等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../rocketmq"
  				data-tags=""
  				data-name="RocketMQ"
  				data-summary="采集 RocketMQ 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="RocketMQ" class="fth-integration-name">RocketMQ</div>
                            <div title="采集 RocketMQ 相关指标信息" class="fth-integration-desc">采集 RocketMQ 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../rum"
  				data-tags="RUM"
  				data-name="RUM"
  				data-summary="采集用户行为数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/rum/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="RUM" class="fth-integration-name">RUM</div>
                            <div title="采集用户行为数据" class="fth-integration-desc">采集用户行为数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../seata"
  				data-tags=""
  				data-name="Seata"
  				data-summary="采集 Seata 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/seata/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Seata" class="fth-integration-name">Seata</div>
                            <div title="采集 Seata 相关指标信息" class="fth-integration-desc">采集 Seata 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../sec-checker"
  				data-tags="安全"
  				data-name="SCheck"
  				data-summary="接收 SCheck 采集的数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/scheck/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="SCheck" class="fth-integration-name">SCheck</div>
                            <div title="接收 SCheck 采集的数据" class="fth-integration-desc">接收 SCheck 采集的数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../sensors"
  				data-tags="主机"
  				data-name="硬件 Sensors 数据采集"
  				data-summary="通过 Sensors 命令采集硬件温度指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/sensors/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="硬件 Sensors 数据采集" class="fth-integration-name">硬件 Sensors 数据采集</div>
                            <div title="通过 Sensors 命令采集硬件温度指标" class="fth-integration-desc">通过 Sensors 命令采集硬件温度指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../skywalking"
  				data-tags="链路追踪,SKYWALKING"
  				data-name="SkyWalking"
  				data-summary="SkyWalking Tracing 数据接入"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/skywalking/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="SkyWalking" class="fth-integration-name">SkyWalking</div>
                            <div title="SkyWalking Tracing 数据接入" class="fth-integration-desc">SkyWalking Tracing 数据接入</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../smart"
  				data-tags="主机"
  				data-name="磁盘 S.M.A.R.T"
  				data-summary="通过 `smartctl` 采集磁盘指标"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/smartctl/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="磁盘 S.M.A.R.T" class="fth-integration-name">磁盘 S.M.A.R.T</div>
                            <div title="通过 `smartctl` 采集磁盘指标" class="fth-integration-desc">通过 `smartctl` 采集磁盘指标</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../snmp"
  				data-tags="SNMP"
  				data-name="SNMP"
  				data-summary="采集 SNMP 设备的指标和对象数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/snmp/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="SNMP" class="fth-integration-name">SNMP</div>
                            <div title="采集 SNMP 设备的指标和对象数据" class="fth-integration-desc">采集 SNMP 设备的指标和对象数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../socket"
  				data-tags="网络"
  				data-name="Socket"
  				data-summary="采集 TCP/UDP 端口的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/socket/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Socket" class="fth-integration-name">Socket</div>
                            <div title="采集 TCP/UDP 端口的指标数据" class="fth-integration-desc">采集 TCP/UDP 端口的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../solr"
  				data-tags="数据库"
  				data-name="Solr"
  				data-summary="采集 Solr 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/solr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Solr" class="fth-integration-name">Solr</div>
                            <div title="采集 Solr 的指标数据" class="fth-integration-desc">采集 Solr 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../sqlserver"
  				data-tags="数据库"
  				data-name="SQLServer"
  				data-summary="采集 SQLServer 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="SQLServer" class="fth-integration-name">SQLServer</div>
                            <div title="采集 SQLServer 的指标数据" class="fth-integration-desc">采集 SQLServer 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../ssh"
  				data-tags="主机"
  				data-name="SSH"
  				data-summary="采集 SSH 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ssh/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="SSH" class="fth-integration-name">SSH</div>
                            <div title="采集 SSH 的指标数据" class="fth-integration-desc">采集 SSH 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../statsd"
  				data-tags="外部数据接入"
  				data-name="StatsD"
  				data-summary="收集 StatsD 上报的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/statsd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="StatsD" class="fth-integration-name">StatsD</div>
                            <div title="收集 StatsD 上报的指标数据" class="fth-integration-desc">收集 StatsD 上报的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../swap"
  				data-tags="主机"
  				data-name="Swap"
  				data-summary="采集主机 swap 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/swap/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Swap" class="fth-integration-name">Swap</div>
                            <div title="采集主机 swap 的指标数据" class="fth-integration-desc">采集主机 swap 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../system"
  				data-tags="主机"
  				data-name="System"
  				data-summary="采集主机系统相关的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/system/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="System" class="fth-integration-name">System</div>
                            <div title="采集主机系统相关的指标数据" class="fth-integration-desc">采集主机系统相关的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tdengine"
  				data-tags="数据库"
  				data-name="TDengine"
  				data-summary="采集 TDengine 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tdengine/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="TDengine" class="fth-integration-name">TDengine</div>
                            <div title="采集 TDengine 的指标数据" class="fth-integration-desc">采集 TDengine 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../telegraf"
  				data-tags="外部数据接入"
  				data-name="Telegraf"
  				data-summary="接收 Telegraf 采集的数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/telegraf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Telegraf" class="fth-integration-name">Telegraf</div>
                            <div title="接收 Telegraf 采集的数据" class="fth-integration-desc">接收 Telegraf 采集的数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_cdb"
  				data-tags="腾讯云"
  				data-name="腾讯云 CDB"
  				data-summary="使用脚本市场中「官方脚本市场」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 CDB" class="fth-integration-name">腾讯云 CDB</div>
                            <div title="使用脚本市场中「官方脚本市场」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「官方脚本市场」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_ckafka"
  				data-tags="腾讯云"
  				data-name="腾讯云 CKafka"
  				data-summary="腾讯云CKafka的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了CKafka在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_ckafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 CKafka" class="fth-integration-name">腾讯云 CKafka</div>
                            <div title="腾讯云CKafka的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了CKafka在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。" class="fth-integration-desc">腾讯云CKafka的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了CKafka在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_clb_private"
  				data-tags="腾讯云"
  				data-name="腾讯云 CLB Private"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 CLB Private" class="fth-integration-name">腾讯云 CLB Private</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_clb_public"
  				data-tags="腾讯云"
  				data-name="腾讯云 CLB Public"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 CLB Public" class="fth-integration-name">腾讯云 CLB Public</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_cos"
  				data-tags="腾讯云"
  				data-name="腾讯云 COS"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 COS" class="fth-integration-name">腾讯云 COS</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_cvm"
  				data-tags="腾讯云"
  				data-name="腾讯云 CVM"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 CVM" class="fth-integration-name">腾讯云 CVM</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_keewidb"
  				data-tags="腾讯云"
  				data-name="腾讯云 KeeWiDB"
  				data-summary="腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_keewidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 KeeWiDB" class="fth-integration-name">腾讯云 KeeWiDB</div>
                            <div title="腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等" class="fth-integration-desc">腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_mariadb"
  				data-tags="腾讯云"
  				data-name="腾讯云 MariaDB"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 MariaDB" class="fth-integration-name">腾讯云 MariaDB</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_memcached"
  				data-tags="腾讯云"
  				data-name="腾讯云 Memcached"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 Memcached" class="fth-integration-name">腾讯云 Memcached</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_mongodb"
  				data-tags="腾讯云"
  				data-name="腾讯云 MongoDB"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 MongoDB" class="fth-integration-name">腾讯云 MongoDB</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_postgresql"
  				data-tags="腾讯云"
  				data-name="腾讯云 PostgreSQL"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 PostgreSQL" class="fth-integration-name">腾讯云 PostgreSQL</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_redis_mem"
  				data-tags="腾讯云"
  				data-name="腾讯云 Redis"
  				data-summary="腾讯云 Redis 指标展示，包括连接数、请求数、时延、慢查询等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_redis_mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 Redis" class="fth-integration-name">腾讯云 Redis</div>
                            <div title="腾讯云 Redis 指标展示，包括连接数、请求数、时延、慢查询等。" class="fth-integration-desc">腾讯云 Redis 指标展示，包括连接数、请求数、时延、慢查询等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_sqlserver"
  				data-tags="腾讯云"
  				data-name="腾讯云 SQLServer"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 SQLServer" class="fth-integration-name">腾讯云 SQLServer</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tencent_tdsql_c_mysql"
  				data-tags="腾讯云"
  				data-name="腾讯云 TDSQL_C_MySQL"
  				data-summary="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_tdsql_c_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="腾讯云 TDSQL_C_MySQL" class="fth-integration-name">腾讯云 TDSQL_C_MySQL</div>
                            <div title="使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>" class="fth-integration-desc">使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tidb"
  				data-tags=""
  				data-name="TiDB"
  				data-summary="采集 TiDB cluster、TiDB、Etcd、Region 等相关组件指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="TiDB" class="fth-integration-name">TiDB</div>
                            <div title="采集 TiDB cluster、TiDB、Etcd、Region 等相关组件指标信息" class="fth-integration-desc">采集 TiDB cluster、TiDB、Etcd、Region 等相关组件指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tomcat"
  				data-tags="WEB SERVER,中间件"
  				data-name="Tomcat"
  				data-summary="采集 Tomcat 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tomcat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tomcat" class="fth-integration-name">Tomcat</div>
                            <div title="采集 Tomcat 的指标数据" class="fth-integration-desc">采集 Tomcat 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../tracing-propagator"
  				data-tags="链路追踪"
  				data-name="Tracing Propagator"
  				data-summary="多链路中的信息传播机制及使用"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tracing Propagator" class="fth-integration-name">Tracing Propagator</div>
                            <div title="多链路中的信息传播机制及使用" class="fth-integration-desc">多链路中的信息传播机制及使用</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../trino"
  				data-tags=""
  				data-name="Trino"
  				data-summary="采集 Trino 指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/trino/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Trino" class="fth-integration-name">Trino</div>
                            <div title="采集 Trino 指标信息" class="fth-integration-desc">采集 Trino 指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../vmware"
  				data-tags=""
  				data-name="VMware"
  				data-summary="VMware 展示集群状态、宿主机状态、VM状态等指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/vmware/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="VMware" class="fth-integration-name">VMware</div>
                            <div title="VMware 展示集群状态、宿主机状态、VM状态等指标。" class="fth-integration-desc">VMware 展示集群状态、宿主机状态、VM状态等指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_alb"
  				data-tags="火山引擎"
  				data-name="火山引擎 ALB"
  				data-summary="采集火山引擎 ALB 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_alb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 ALB" class="fth-integration-name">火山引擎 ALB</div>
                            <div title="采集火山引擎 ALB 指标数据" class="fth-integration-desc">采集火山引擎 ALB 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_clb"
  				data-tags="火山引擎"
  				data-name="火山引擎 CLB"
  				data-summary="采集火山引擎 CLB 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 CLB" class="fth-integration-name">火山引擎 CLB</div>
                            <div title="采集火山引擎 CLB 指标数据" class="fth-integration-desc">采集火山引擎 CLB 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_ecs"
  				data-tags="火山引擎"
  				data-name="火山引擎 ECS"
  				data-summary="火山引擎 ECS 的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 ECS" class="fth-integration-name">火山引擎 ECS</div>
                            <div title="火山引擎 ECS 的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。" class="fth-integration-desc">火山引擎 ECS 的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_eip"
  				data-tags="火山引擎"
  				data-name="火山引擎 EIP"
  				data-summary="采集火山引擎 EIP 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 EIP" class="fth-integration-name">火山引擎 EIP</div>
                            <div title="采集火山引擎 EIP 指标数据" class="fth-integration-desc">采集火山引擎 EIP 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_mongodb_replica_set"
  				data-tags="火山引擎"
  				data-name="火山引擎 MongoDB 副本集"
  				data-summary="火山引擎 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 MongoDB 副本集" class="fth-integration-name">火山引擎 MongoDB 副本集</div>
                            <div title="火山引擎 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。" class="fth-integration-desc">火山引擎 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_mongodb_sharded_cluster"
  				data-tags="火山引擎"
  				data-name="火山引擎 MongoDB 分片集"
  				data-summary="火山引擎 MongoDB 分片集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 MongoDB 分片集" class="fth-integration-name">火山引擎 MongoDB 分片集</div>
                            <div title="火山引擎 MongoDB 分片集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。" class="fth-integration-desc">火山引擎 MongoDB 分片集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_mysql"
  				data-tags="火山引擎"
  				data-name="火山引擎 MySQL"
  				data-summary="火山引擎 MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 MySQL" class="fth-integration-name">火山引擎 MySQL</div>
                            <div title="火山引擎 MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。" class="fth-integration-desc">火山引擎 MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_nas"
  				data-tags="火山引擎"
  				data-name="火山引擎 NAS 文件存储"
  				data-summary="采集火山引擎 NAS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_nas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 NAS 文件存储" class="fth-integration-name">火山引擎 NAS 文件存储</div>
                            <div title="采集火山引擎 NAS 指标数据" class="fth-integration-desc">采集火山引擎 NAS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_redis"
  				data-tags="火山引擎"
  				data-name="火山引擎 Redis"
  				data-summary="火山引擎 Redis 指标采集"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 Redis" class="fth-integration-name">火山引擎 Redis</div>
                            <div title="火山引擎 Redis 指标采集" class="fth-integration-desc">火山引擎 Redis 指标采集</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_tos"
  				data-tags="火山引擎"
  				data-name="火山引擎 TOS 对象存储"
  				data-summary="采集火山引擎 TOS 指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_tos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 TOS 对象存储" class="fth-integration-name">火山引擎 TOS 对象存储</div>
                            <div title="采集火山引擎 TOS 指标数据" class="fth-integration-desc">采集火山引擎 TOS 指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../volcengine_vke"
  				data-tags="火山引擎"
  				data-name="火山引擎 VKE"
  				data-summary="火山云 VKE 指标采集，包括 Cluster、Container、Node、Pod等。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_vke/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="火山引擎 VKE" class="fth-integration-name">火山引擎 VKE</div>
                            <div title="火山云 VKE 指标采集，包括 Cluster、Container、Node、Pod等。" class="fth-integration-desc">火山云 VKE 指标采集，包括 Cluster、Container、Node、Pod等。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../vsphere"
  				data-tags="VMWARE"
  				data-name="vSphere"
  				data-summary="采集 vSphere 的指标数据"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/vsphere/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="vSphere" class="fth-integration-name">vSphere</div>
                            <div title="采集 vSphere 的指标数据" class="fth-integration-desc">采集 vSphere 的指标数据</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../windows_event"
  				data-tags="WINDOWS"
  				data-name="Windows 事件"
  				data-summary="采集 Windows 中的事件日志"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/winevent/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Windows 事件" class="fth-integration-name">Windows 事件</div>
                            <div title="采集 Windows 中的事件日志" class="fth-integration-desc">采集 Windows 中的事件日志</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../xfsquota"
  				data-tags=""
  				data-name="xfsquota"
  				data-summary="采集 xfs 文件系统的限额信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="xfsquota" class="fth-integration-name">xfsquota</div>
                            <div title="采集 xfs 文件系统的限额信息" class="fth-integration-desc">采集 xfs 文件系统的限额信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../zabbix_exporter"
  				data-tags="外部数据接入"
  				data-name="Zabbix 数据接入"
  				data-summary="Zabbix realTime data 数据接入"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zabbix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Zabbix 数据接入" class="fth-integration-name">Zabbix 数据接入</div>
                            <div title="Zabbix realTime data 数据接入" class="fth-integration-desc">Zabbix realTime data 数据接入</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../zadigx"
  				data-tags=""
  				data-name="Zadigx"
  				data-summary="Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等指标。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zadigx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Zadigx" class="fth-integration-name">Zadigx</div>
                            <div title="Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等指标。" class="fth-integration-desc">Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等指标。</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../zipkin"
  				data-tags="ZIPKIN,链路追踪"
  				data-name="Zipkin"
  				data-summary="Zipkin Tracing 数据接入"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zipkin/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Zipkin" class="fth-integration-name">Zipkin</div>
                            <div title="Zipkin Tracing 数据接入" class="fth-integration-desc">Zipkin Tracing 数据接入</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../zookeeper"
  				data-tags=""
  				data-name="ZooKeeper"
  				data-summary="采集 zookeeper 相关指标信息"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zookeeper/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="ZooKeeper" class="fth-integration-name">ZooKeeper</div>
                            <div title="采集 zookeeper 相关指标信息" class="fth-integration-desc">采集 zookeeper 相关指标信息</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  		</div>
  		<!-- end-集成list -->
  	</div>
  	<script>
  		!(function () {
            const limitTags = ['阿里云', '腾讯云', '华为云', '火山引擎','谷歌云', 'AWS', 'AZURE',"GCP", '中间件', '主机', 'IPMI', 'KUBERNETES', '容器', '网络', 'EBPF', 'BPF', 'SNMP', 'PROMETHEUS', 'ZABBIX', 'TELEGRAF', '缓存', '消息队列', '数据库', '语言', '链路追踪', 'PROFILE', '日志', '拨测', 'WEB', '移动端', 'CI/CD', 'JENKINS', 'GITLAB', '会话重放', 'WINDOWS'];
            const limitTagsToLower=limitTags.map(v=>v.toLowerCase())
            const tagAll = { label: '全部', value: '' };
  			const debounce = (fn, delay, immediate) => {
                let timeout = null;
                let result = undefined;
                const that = this;
                const debounced = function (that, ...args) {
                    if (timeout) clearTimeout(timeout);
                    if (immediate) {
                        const canNow = !timeout;
                        timeout = setTimeout(() => {
                            timeout = null;
                        }, delay);
                        if (canNow) result = fn.apply(this, args);
                    } else {
                        timeout = setTimeout(() => {
                            result = fn.apply(this, args);
                        }, delay);
                    }
                    return result;
                };
                debounced.cancel = () => {
                    clearTimeout(timeout);
                    timeout = null;
                };
                return debounced;
            };
            const container = document.querySelector('.integration-doc-container');
            const search = container.querySelector('.integration-search-intput');
            const header = container.querySelector('.fth-integration-list-header');
            const content = container.querySelector('.fth-integration-list-content');
            let originList = [];
            const debounceSearchFn = debounce(searchIntegration, 300);
            let searchValue = '';
            let tagValue = '';
            const inputChange = function (e) {
                const value = this.value;
                searchValue = value && value.toLowerCase();
                tagValue = '';
                debounceSearchFn();
            };
            const tagChange = function (e) {
                if (e.target.classList.contains('integration-tags-group-item')) {
                    const curTag = e.target;
                    const activeTag = header.querySelector('.integration-tags-group-item.tag-active');
                    const tagAllContainer = header.querySelector('.integration-tags-group-item');
                    if (curTag !== activeTag) {
                        tagValue = curTag.dataset.tag;
                        curTag.classList.add('tag-active');
                    } else {
                        if (activeTag === tagAllContainer) {
                            return;
                        }
                        tagValue = tagAll.value;
                        tagAllContainer && tagAllContainer.classList.add('tag-active');
                    }
                    if (activeTag) {
                        activeTag.classList.remove('tag-active');
                    }
                    searchIntegration('tag');
                }
            };

            //   根据 tag 和 search 搜索内容
            function searchIntegration(type) {
                // type 两种类型 'tag' 'search'
                const search = searchValue;
                const tag = tagValue;
                const tagObj = {};
                const isSearch = type !== 'tag';
                originList.forEach(item => {
                    const { tags, name, summary, dom } = item;
                    const show =
                        ((!tags && !tag) || tags.toLowerCase().includes(tag && tag.toLowerCase())) && (!name || name.includes(search) || summary.includes(search) || tags.toLowerCase().includes(search));
                    dom.style.display = show ? 'block' : 'none';
                    // 如果是搜索触发 需重新计算tags
                    if (isSearch && show && tags) {
                        let tagsArr = tags.split(',');
                        tagsArr = tagsArr.forEach(v => {
                            const index = limitTagsToLower.indexOf(v.toLowerCase())

                            if (index > -1) {
                                const curTag = limitTags[index]
                                if (tagObj[curTag]) {
                                    tagObj[curTag] += 1;
                                } else {
                                    tagObj[curTag] = 1;
                                }
                            }
                        })
                    }
                });
                if (isSearch) {
                    tagValue = '';
                    const tagContainer = header.querySelector('.integration-tags-group');
                    if (Object.keys(tagObj).length) {
                        const tags = Object.entries(tagObj).reduce(
                            (acc, cur) => {
                                const [key, value] = cur;
                                const keyIndex = limitTagsToLower.indexOf(key && key.toLowerCase());
                                if (keyIndex > -1) {
                                    acc.push({ label: `${key} (${value})`, value: key, index: keyIndex });
                                }
                                return acc;
                            },
                            [{ ...tagAll, index: -1 }]
                        )
                            .sort((a, b) => a.index - b.index)

                        tagContainer.innerHTML = tags.map(
                            (tag) =>
                                `<div class="integration-tags-group-item ${tag.label === tagAll.label ? 'tag-active' : ''
                                }" data-tag="${tag.value}">${tag.label}</div>`
                        ).join('');
                    } else {
                        tagContainer.innerHTML = '';
                    }
                }
            }
            header.querySelector('.integration-search-input').addEventListener('input', inputChange);
            header.addEventListener('click', tagChange);
            content.addEventListener('click', e => {
                let ele = e.target;
                let i = 0;
                while (i < 5) {
                    if (ele.classList.contains('fth-integration-list-item')) {
                        const href = ele.dataset.href;
                        href && window.open(href);
                        break;
                    }
                    i++;
                    ele = ele.parentNode;
                }
            });
            function init() {
                const list = container.querySelectorAll('.fth-integration-list-item');
                list.forEach(item => {
                    const { tags: tagsStr, name: nameStr, summary: summaryStr } = item.dataset || {};
                    const tags = tagsStr || '';
                    const name = (nameStr && nameStr.toLowerCase()) || '';
                    const summary = summaryStr ? summaryStr.toLowerCase() : '';
                    name && originList.push({ tags, name, summary, dom: item });
                });
                searchIntegration();
            }
            init();
        })();
  	</script>
  </div>
</html>
<!-- markdownlint-enable -->
