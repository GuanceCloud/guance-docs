---
icon: zy/integrations
---

# Integrations

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
  			<input placeholder="Search" class="integration-search-input" type="text" />
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
  				data-summary="Collect related Metrics information of Active Directory"
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
                            <div title="Collect related Metrics information of Active Directory" class="fth-integration-desc">Collect related Metrics information of Active Directory</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Aerospike related Metrics information"
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
                            <div title="Collect Aerospike related Metrics information" class="fth-integration-desc">Collect Aerospike related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud AnalyticDB PostgreSQL"
  				data-summary="Alibaba Cloud AnalyticDB PostgreSQL Metrics Display, including CPU, memory, disk, coordination nodes, instance queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_analyticdb_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud AnalyticDB PostgreSQL" class="fth-integration-name">Alibaba Cloud AnalyticDB PostgreSQL</div>
                            <div title="Alibaba Cloud AnalyticDB PostgreSQL Metrics Display, including CPU, memory, disk, coordination nodes, instance queries, etc." class="fth-integration-desc">Alibaba Cloud AnalyticDB PostgreSQL Metrics Display, including CPU, memory, disk, coordination nodes, instance queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Billing"
  				data-summary="Collecting Alibaba Cloud billing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_billing/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Billing" class="fth-integration-name">Alibaba Cloud Billing</div>
                            <div title="Collecting Alibaba Cloud billing information" class="fth-integration-desc">Collecting Alibaba Cloud billing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud CDN"
  				data-summary="Alibaba Cloud CDN performance Metrics display, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_cdn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud CDN" class="fth-integration-name">Alibaba Cloud CDN</div>
                            <div title="Alibaba Cloud CDN performance Metrics display, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc." class="fth-integration-desc">Alibaba Cloud CDN performance Metrics display, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud ClickHouse Community-Compatible Edition"
  				data-summary="Display of Alibaba Cloud ClickHouse Metrics, including service status, log traffic, operation counts, total QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_clickhouse_community/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud ClickHouse Community-Compatible Edition" class="fth-integration-name">Alibaba Cloud ClickHouse Community-Compatible Edition</div>
                            <div title="Display of Alibaba Cloud ClickHouse Metrics, including service status, log traffic, operation counts, total QPS, etc." class="fth-integration-desc">Display of Alibaba Cloud ClickHouse Metrics, including service status, log traffic, operation counts, total QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud,HOSTs"
  				data-name="Alibaba Cloud ECS"
  				data-summary="The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, networking, and storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud ECS" class="fth-integration-name">Alibaba Cloud ECS</div>
                            <div title="The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, networking, and storage." class="fth-integration-desc">The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, networking, and storage.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud EDAS"
  				data-summary="Collect Alibaba Cloud EDAS Metrics and APM data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_edas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud EDAS" class="fth-integration-name">Alibaba Cloud EDAS</div>
                            <div title="Collect Alibaba Cloud EDAS Metrics and APM data" class="fth-integration-desc">Collect Alibaba Cloud EDAS Metrics and APM data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud EIP"
  				data-summary="Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, speed-limited packet drop rate, bandwidth utilization, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud EIP" class="fth-integration-name">Alibaba Cloud EIP</div>
                            <div title="Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, speed-limited packet drop rate, bandwidth utilization, etc." class="fth-integration-desc">Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, speed-limited packet drop rate, bandwidth utilization, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud ElasticSearch"
  				data-summary="Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud ElasticSearch" class="fth-integration-name">Alibaba Cloud ElasticSearch</div>
                            <div title="Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage, etc." class="fth-integration-desc">Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud KafKa"
  				data-summary="Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, message consumption frequency, etc. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud KafKa" class="fth-integration-name">Alibaba Cloud KafKa</div>
                            <div title="Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, message consumption frequency, etc. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams." class="fth-integration-desc">Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, message consumption frequency, etc. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Lindorm"
  				data-summary="Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_lindorm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Lindorm" class="fth-integration-name">Alibaba Cloud Lindorm</div>
                            <div title="Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>." class="fth-integration-desc">Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud MongoDB"
  				data-summary="Alibaba Cloud MongoDB Replica Set Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Sharded Cluster Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Single Node Instance Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, number of statements executed per second, request count, connection count, network traffic, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud MongoDB" class="fth-integration-name">Alibaba Cloud MongoDB</div>
                            <div title="Alibaba Cloud MongoDB Replica Set Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Sharded Cluster Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Single Node Instance Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, number of statements executed per second, request count, connection count, network traffic, QPS, etc." class="fth-integration-desc">Alibaba Cloud MongoDB Replica Set Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Sharded Cluster Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB Single Node Instance Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, number of statements executed per second, request count, connection count, network traffic, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud NAT"
  				data-summary="Alibaba Cloud NAT Metrics Display, including concurrent connections, new connections, VPC traffic, VPC packets, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_nat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud NAT" class="fth-integration-name">Alibaba Cloud NAT</div>
                            <div title="Alibaba Cloud NAT Metrics Display, including concurrent connections, new connections, VPC traffic, VPC packets, etc." class="fth-integration-desc">Alibaba Cloud NAT Metrics Display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud DDoS New BGP High Defense"
  				data-summary="The displayed Metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These Metrics reflect the performance and credibility of the New BGP High Defense service when dealing with large-scale DDoS attacks."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_newbgp_ddos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud DDoS New BGP High Defense" class="fth-integration-name">Alibaba Cloud DDoS New BGP High Defense</div>
                            <div title="The displayed Metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These Metrics reflect the performance and credibility of the New BGP High Defense service when dealing with large-scale DDoS attacks." class="fth-integration-desc">The displayed Metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These Metrics reflect the performance and credibility of the New BGP High Defense service when dealing with large-scale DDoS attacks.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud OSS"
  				data-summary="Alibaba Cloud OSS Metrics Display, including request counts, availability, network traffic, and request ratios."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_oss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud OSS" class="fth-integration-name">Alibaba Cloud OSS</div>
                            <div title="Alibaba Cloud OSS Metrics Display, including request counts, availability, network traffic, and request ratios." class="fth-integration-desc">Alibaba Cloud OSS Metrics Display, including request counts, availability, network traffic, and request ratios.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud PolarDB Distributed 1.0"
  				data-summary="Alibaba Cloud PolarDB Distributed 1.0 Metrics include CPU utilization, memory utilization, network bandwidth, and disk IOPS."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud PolarDB Distributed 1.0" class="fth-integration-name">Alibaba Cloud PolarDB Distributed 1.0</div>
                            <div title="Alibaba Cloud PolarDB Distributed 1.0 Metrics include CPU utilization, memory utilization, network bandwidth, and disk IOPS." class="fth-integration-desc">Alibaba Cloud PolarDB Distributed 1.0 Metrics include CPU utilization, memory utilization, network bandwidth, and disk IOPS.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud PolarDB Distributed 2.0"
  				data-summary="Alibaba Cloud PolarDB Distributed 2.0 displays Metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage volume, disk usage rate, memory utilization, network bandwidth, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud PolarDB Distributed 2.0" class="fth-integration-name">Alibaba Cloud PolarDB Distributed 2.0</div>
                            <div title="Alibaba Cloud PolarDB Distributed 2.0 displays Metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage volume, disk usage rate, memory utilization, network bandwidth, etc." class="fth-integration-desc">Alibaba Cloud PolarDB Distributed 2.0 displays Metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage volume, disk usage rate, memory utilization, network bandwidth, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud PolarDB MySQL"
  				data-summary="Alibaba Cloud PolarDB MySQL Metrics display, including CPU usage, memory hit rate, network traffic, connection count, QPS, TPS, read-only node delay, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud PolarDB MySQL" class="fth-integration-name">Alibaba Cloud PolarDB MySQL</div>
                            <div title="Alibaba Cloud PolarDB MySQL Metrics display, including CPU usage, memory hit rate, network traffic, connection count, QPS, TPS, read-only node delay, etc." class="fth-integration-desc">Alibaba Cloud PolarDB MySQL Metrics display, including CPU usage, memory hit rate, network traffic, connection count, QPS, TPS, read-only node delay, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud PolarDB Oracle"
  				data-summary="Alibaba Cloud PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud PolarDB Oracle" class="fth-integration-name">Alibaba Cloud PolarDB Oracle</div>
                            <div title="Alibaba Cloud PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc." class="fth-integration-desc">Alibaba Cloud PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud PolarDB PostgreSQL"
  				data-summary="Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud PolarDB PostgreSQL" class="fth-integration-name">Alibaba Cloud PolarDB PostgreSQL</div>
                            <div title="Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc." class="fth-integration-desc">Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RDS MariaDB"
  				data-summary="The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RDS MariaDB" class="fth-integration-name">Alibaba Cloud RDS MariaDB</div>
                            <div title="The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc." class="fth-integration-desc">The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RDS MySQL"
  				data-summary="Alibaba Cloud RDS MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RDS MySQL" class="fth-integration-name">Alibaba Cloud RDS MySQL</div>
                            <div title="Alibaba Cloud RDS MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">Alibaba Cloud RDS MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RDS PostgreSQL"
  				data-summary="Display of Alibaba Cloud RDS PostgreSQL Metrics, including CPU usage, memory usage, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RDS PostgreSQL" class="fth-integration-name">Alibaba Cloud RDS PostgreSQL</div>
                            <div title="Display of Alibaba Cloud RDS PostgreSQL Metrics, including CPU usage, memory usage, etc." class="fth-integration-desc">Display of Alibaba Cloud RDS PostgreSQL Metrics, including CPU usage, memory usage, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RDS SQLServer"
  				data-summary="Alibaba Cloud RDS SQLServer Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RDS SQLServer" class="fth-integration-name">Alibaba Cloud RDS SQLServer</div>
                            <div title="Alibaba Cloud RDS SQLServer Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">Alibaba Cloud RDS SQLServer Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Redis Standard Edition"
  				data-summary="Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Redis Standard Edition" class="fth-integration-name">Alibaba Cloud Redis Standard Edition</div>
                            <div title="Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc." class="fth-integration-desc">Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Redis Cluster Edition"
  				data-summary="Alibaba Cloud Redis Cluster Edition Metrics Display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Redis Cluster Edition" class="fth-integration-name">Alibaba Cloud Redis Cluster Edition</div>
                            <div title="Alibaba Cloud Redis Cluster Edition Metrics Display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc." class="fth-integration-desc">Alibaba Cloud Redis Cluster Edition Metrics Display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RocketMQ4"
  				data-summary="The display metrics of Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RocketMQ4" class="fth-integration-name">Alibaba Cloud RocketMQ4</div>
                            <div title="The display metrics of Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability." class="fth-integration-desc">The display metrics of Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud RocketMQ5"
  				data-summary="The display metrics of Alibaba Cloud RocketMQ 5.0 include message throughput, latency, reliability, and horizontal scalability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud RocketMQ5" class="fth-integration-name">Alibaba Cloud RocketMQ5</div>
                            <div title="The display metrics of Alibaba Cloud RocketMQ 5.0 include message throughput, latency, reliability, and horizontal scalability." class="fth-integration-desc">The display metrics of Alibaba Cloud RocketMQ 5.0 include message throughput, latency, reliability, and horizontal scalability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud SAE"
  				data-summary="Collect Metrics, Logs, and Traces from Alibaba Cloud SAE (Serverless App Engine)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sae/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud SAE" class="fth-integration-name">Alibaba Cloud SAE</div>
                            <div title="Collect Metrics, Logs, and Traces from Alibaba Cloud SAE (Serverless App Engine)" class="fth-integration-desc">Collect Metrics, Logs, and Traces from Alibaba Cloud SAE (Serverless App Engine)</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Site Monitoring"
  				data-summary="Alibaba Cloud Site Monitoring primarily collects site dial test information."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_site/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Site Monitoring" class="fth-integration-name">Alibaba Cloud Site Monitoring</div>
                            <div title="Alibaba Cloud Site Monitoring primarily collects site dial test information." class="fth-integration-desc">Alibaba Cloud Site Monitoring primarily collects site dial test information.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud SLB"
  				data-summary="Alibaba Cloud SLB Metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_slb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud SLB" class="fth-integration-name">Alibaba Cloud SLB</div>
                            <div title="Alibaba Cloud SLB Metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc." class="fth-integration-desc">Alibaba Cloud SLB Metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud SLS"
  				data-summary="Alibaba Cloud SLS Metrics display, including service status, log traffic, number of operations, total QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sls/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud SLS" class="fth-integration-name">Alibaba Cloud SLS</div>
                            <div title="Alibaba Cloud SLS Metrics display, including service status, log traffic, number of operations, total QPS, etc." class="fth-integration-desc">Alibaba Cloud SLS Metrics display, including service status, log traffic, number of operations, total QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Alibaba Cloud Tair Community Edition"
  				data-summary="Display of metrics for the Alibaba Cloud Tair Community Edition, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_tair/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Alibaba Cloud Tair Community Edition" class="fth-integration-name">Alibaba Cloud Tair Community Edition</div>
                            <div title="Display of metrics for the Alibaba Cloud Tair Community Edition, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc." class="fth-integration-desc">Display of metrics for the Alibaba Cloud Tair Community Edition, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE,WEB SERVER"
  				data-name="Apache"
  				data-summary="Apache collector can collect the number of requests, connections, etc. from the Apache service"
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
                            <div title="Apache collector can collect the number of requests, connections, etc. from the Apache service" class="fth-integration-desc">Apache collector can collect the number of requests, connections, etc. from the Apache service</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect APISIX related Metrics, LOGs, and APM information"
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
                            <div title="Collect APISIX related Metrics, LOGs, and APM information" class="fth-integration-desc">Collect APISIX related Metrics, LOGs, and APM information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Apollo related metrics information"
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
                            <div title="Collect Apollo related metrics information" class="fth-integration-desc">Collect Apollo related metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Argo CD service status, application status, and logs, as well as tracing information"
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
                            <div title="Collect Argo CD service status, application status, and logs, as well as tracing information" class="fth-integration-desc">Collect Argo CD service status, application status, and logs, as well as tracing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect AutoMQ related Metrics information"
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
                            <div title="Collect AutoMQ related Metrics information" class="fth-integration-desc">Collect AutoMQ related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management."
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
                            <div title="The displayed metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management." class="fth-integration-desc">The displayed metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS Auto Scaling, including the number of instances, capacity units, warm pools, etc."
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
                            <div title="AWS Auto Scaling, including the number of instances, capacity units, warm pools, etc." class="fth-integration-desc">AWS Auto Scaling, including the number of instances, capacity units, warm pools, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="AWS Cloud Billing"
  				data-summary="Collect AWS cloud billing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Cloud Billing" class="fth-integration-name">AWS Cloud Billing</div>
                            <div title="Collect AWS cloud billing information" class="fth-integration-desc">Collect AWS cloud billing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network."
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
                            <div title="The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network." class="fth-integration-desc">The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These Metrics reflect the performance and reliability of DMS during database migration and replication."
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
                            <div title="The displayed Metrics for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These Metrics reflect the performance and reliability of DMS during database migration and replication." class="fth-integration-desc">The displayed Metrics for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These Metrics reflect the performance and reliability of DMS during database migration and replication.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc."
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
                            <div title="The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc." class="fth-integration-desc">The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, etc. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access."
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
                            <div title="The displayed Metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, etc. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access." class="fth-integration-desc">The displayed Metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, etc. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX."
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
                            <div title="The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX." class="fth-integration-desc">The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script package series of 「<<< custom_key.brand_name >>> Cloud Sync」in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script package series of 「<<< custom_key.brand_name >>> Cloud Sync」in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script package series of 「<<< custom_key.brand_name >>> Cloud Sync」in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary=" Amazon EC2 Spot, including request capacity pools, target capacity pools, and abort capacity."
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
                            <div title=" Amazon EC2 Spot, including request capacity pools, target capacity pools, and abort capacity." class="fth-integration-desc"> Amazon EC2 Spot, including request capacity pools, target capacity pools, and abort capacity.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Amazon ECS features are integrated with Amazon Web Services Fargate serverless computing engine, using <<< custom_key.brand_name >>> to monitor the service runtime."
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
                            <div title="Amazon ECS features are integrated with Amazon Web Services Fargate serverless computing engine, using <<< custom_key.brand_name >>> to monitor the service runtime." class="fth-integration-desc">Amazon ECS features are integrated with Amazon Web Services Fargate serverless computing engine, using <<< custom_key.brand_name >>> to monitor the service runtime.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script package series of "<<< custom_key.brand_name >>> Cloud Sync" in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script package series of "<<< custom_key.brand_name >>> Cloud Sync" in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script package series of "<<< custom_key.brand_name >>> Cloud Sync" in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the Script Market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the Script Market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the Script Market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>."
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
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>." class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge when handling large-scale event streams and real-time data delivery."
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
                            <div title="The displayed Metrics for AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge when handling large-scale event streams and real-time data delivery." class="fth-integration-desc">The displayed Metrics for AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge when handling large-scale event streams and real-time data delivery.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Send Firehose logs or metrics to Guance"
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
                            <div title="Send Firehose logs or metrics to Guance" class="fth-integration-desc">Send Firehose logs or metrics to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market named «<<< custom_key.brand_name >>> Cloud Sync» series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>."
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
                            <div title="Use the script packages in the script market named «<<< custom_key.brand_name >>> Cloud Sync» series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>." class="fth-integration-desc">Use the script packages in the script market named «<<< custom_key.brand_name >>> Cloud Sync» series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for AWS Lambda include cold start time, execution time, number of concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions."
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
                            <div title="The displayed Metrics for AWS Lambda include cold start time, execution time, number of concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions." class="fth-integration-desc">The displayed Metrics for AWS Lambda include cold start time, execution time, number of concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS MediaConvert, including data transfer, video errors, job counts, padding, etc."
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
                            <div title="AWS MediaConvert, including data transfer, video errors, job counts, padding, etc." class="fth-integration-desc">AWS MediaConvert, including data transfer, video errors, job counts, padding, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script market "<<< custom_key.brand_name >>> Cloud Sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script market "<<< custom_key.brand_name >>> Cloud Sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script market "<<< custom_key.brand_name >>> Cloud Sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Amazon MQ supports industry-standard APIs and protocols, managing and maintaining message brokers, and automatically providing infrastructure for high availability."
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
                            <div title="Amazon MQ supports industry-standard APIs and protocols, managing and maintaining message brokers, and automatically providing infrastructure for high availability." class="fth-integration-desc">Amazon MQ supports industry-standard APIs and protocols, managing and maintaining message brokers, and automatically providing infrastructure for high availability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script market series of "<<< custom_key.brand_name >>> Cloud Sync" script packages to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script market series of "<<< custom_key.brand_name >>> Cloud Sync" script packages to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script market series of "<<< custom_key.brand_name >>> Cloud Sync" script packages to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of Neptune Cluster functions."
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
                            <div title="The displayed Metrics for the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of Neptune Cluster functions." class="fth-integration-desc">The displayed Metrics for the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of Neptune Cluster functions.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS OpenSearch, including connection counts, request counts, latency, slow queries, etc."
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
                            <div title="AWS OpenSearch, including connection counts, request counts, latency, slow queries, etc." class="fth-integration-desc">AWS OpenSearch, including connection counts, request counts, latency, slow queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing the performance of a data warehouse."
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
                            <div title="The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing the performance of a data warehouse." class="fth-integration-desc">The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing the performance of a data warehouse.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the series of script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
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
                            <div title="Use the series of script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the series of script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics of AWS Simple Queue Service include the approximate Exist time of the oldest un-deleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc."
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
                            <div title="The displayed metrics of AWS Simple Queue Service include the approximate Exist time of the oldest un-deleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc." class="fth-integration-desc">The displayed metrics of AWS Simple Queue Service include the approximate Exist time of the oldest un-deleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics of AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage, etc."
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
                            <div title="The displayed metrics of AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage, etc." class="fth-integration-desc">The displayed metrics of AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="AWS Lambda Extension"
  				data-summary="Extend data collection through AWS Lambda"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/awslambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="AWS Lambda Extension" class="fth-integration-name">AWS Lambda Extension</div>
                            <div title="Extend data collection through AWS Lambda" class="fth-integration-desc">Extend data collection through AWS Lambda</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure Kubernetes Metrics data"
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
                            <div title="Collect Azure Kubernetes Metrics data" class="fth-integration-desc">Collect Azure Kubernetes Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure Load Balancer Metrics data"
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
                            <div title="Collect Azure Load Balancer Metrics data" class="fth-integration-desc">Collect Azure Load Balancer Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure MySQL Metrics data"
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
                            <div title="Collect Azure MySQL Metrics data" class="fth-integration-desc">Collect Azure MySQL Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure Network Interface Metrics data"
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
                            <div title="Collect Azure Network Interface Metrics data" class="fth-integration-desc">Collect Azure Network Interface Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure PostgreSQL Metrics data"
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
                            <div title="Collect Azure PostgreSQL Metrics data" class="fth-integration-desc">Collect Azure PostgreSQL Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="AZURE,NETWORK"
  				data-name="Azure Public IP Address"
  				data-summary="Collect Azure Public IP Address Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_public_ip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Azure Public IP Address" class="fth-integration-name">Azure Public IP Address</div>
                            <div title="Collect Azure Public IP Address Metrics data" class="fth-integration-desc">Collect Azure Public IP Address Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data from Azure Redis Cache"
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
                            <div title="Collect metrics data from Azure Redis Cache" class="fth-integration-desc">Collect metrics data from Azure Redis Cache</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data from Azure SQL Servers"
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
                            <div title="Collect metrics data from Azure SQL Servers" class="fth-integration-desc">Collect metrics data from Azure SQL Servers</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure Storage metrics data"
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
                            <div title="Collect Azure Storage metrics data" class="fth-integration-desc">Collect Azure Storage metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure Virtual Network Gateway Metrics data"
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
                            <div title="Collect Azure Virtual Network Gateway Metrics data" class="fth-integration-desc">Collect Azure Virtual Network Gateway Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data from Azure Virtual Machines"
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
                            <div title="Collect metrics data from Azure Virtual Machines" class="fth-integration-desc">Collect metrics data from Azure Virtual Machines</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="LOG"
  				data-name="Filebeat"
  				data-summary="Receive log collected by Filebeat "
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
                            <div title="Receive log collected by Filebeat " class="fth-integration-desc">Receive log collected by Filebeat </div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Cassandra"
  				data-summary="Collect Cassandra metrics"
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
                            <div title="Collect Cassandra metrics" class="fth-integration-desc">Collect Cassandra metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="TRACING,APM"
  				data-name="Dianping CAT"
  				data-summary="The performance, capacity, and business indicator monitoring system of Meituan Dianping"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Dianping CAT" class="fth-integration-name">Dianping CAT</div>
                            <div title="The performance, capacity, and business indicator monitoring system of Meituan Dianping" class="fth-integration-desc">The performance, capacity, and business indicator monitoring system of Meituan Dianping</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to Chrony server"
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
                            <div title="Collect metrics related to Chrony server" class="fth-integration-desc">Collect metrics related to Chrony server</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="ClickHouse"
  				data-summary="Collect metrics of ClickHouse"
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
                            <div title="Collect metrics of ClickHouse" class="fth-integration-desc">Collect metrics of ClickHouse</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Cloud Billing Cost Query"
  				data-summary="Cloud billing cost query, which can retrieve billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, and Tencent Cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cloud_billing//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Cloud Billing Cost Query" class="fth-integration-name">Cloud Billing Cost Query</div>
                            <div title="Cloud billing cost query, which can retrieve billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, and Tencent Cloud." class="fth-integration-desc">Cloud billing cost query, which can retrieve billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, and Tencent Cloud.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Cloudprober data"
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
                            <div title="Collect Cloudprober data" class="fth-integration-desc">Collect Cloudprober data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="CockroachDB"
  				data-summary="Collect CockroachDB metrics"
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
                            <div title="Collect CockroachDB metrics" class="fth-integration-desc">Collect CockroachDB metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE"
  				data-name="Confluent Cloud"
  				data-summary="Collect Kafka Metrics data from Confluent Cloud"
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
                            <div title="Collect Kafka Metrics data from Confluent Cloud" class="fth-integration-desc">Collect Kafka Metrics data from Confluent Cloud</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE"
  				data-name="Consul"
  				data-summary="Collect metrics of Consul"
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
                            <div title="Collect metrics of Consul" class="fth-integration-desc">Collect metrics of Consul</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="LOG,CONTAINER,KUBERNETES"
  				data-name="Kubernetes Logs"
  				data-summary="Collect container and Kubernetes log"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes Logs" class="fth-integration-name">Kubernetes Logs</div>
                            <div title="Collect container and Kubernetes log" class="fth-integration-desc">Collect container and Kubernetes log</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="KUBERNETES,CONTAINER"
  				data-name="Kubernetes"
  				data-summary="Collect metrics, objects, and log data for Container and Kubernetes, and report them to the guance cloud."
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
                            <div title="Collect metrics, objects, and log data for Container and Kubernetes, and report them to the guance cloud." class="fth-integration-desc">Collect metrics, objects, and log data for Container and Kubernetes, and report them to the guance cloud.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE"
  				data-name="CoreDNS"
  				data-summary="Collect CoreDNS metrics and logs"
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
                            <div title="Collect CoreDNS metrics and logs" class="fth-integration-desc">Collect CoreDNS metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Couchbase"
  				data-summary="Collect Couchbase server metrics"
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
                            <div title="Collect Couchbase server metrics" class="fth-integration-desc">Collect Couchbase server metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="CouchDB"
  				data-summary="Collect CouchDB server metrics"
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
                            <div title="Collect CouchDB server metrics" class="fth-integration-desc">Collect CouchDB server metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metric of cpu"
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
                            <div title="Collect metric of cpu" class="fth-integration-desc">Collect metric of cpu</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="DB2"
  				data-summary="Collect IBM DB2 metrics"
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
                            <div title="Collect IBM DB2 metrics" class="fth-integration-desc">Collect IBM DB2 metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING,JAVA"
  				data-name="DDTrace Attach "
  				data-summary="Attach DDTrace to Java applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Attach " class="fth-integration-name">DDTrace Attach </div>
                            <div title="Attach DDTrace to Java applications" class="fth-integration-desc">Attach DDTrace to Java applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING,C/C++"
  				data-name="DDTrace C++"
  				data-summary="Tracing C++ Application with DDTrace"
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
                            <div title="Tracing C++ Application with DDTrace" class="fth-integration-desc">Tracing C++ Application with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,APM,TRACING"
  				data-name="DDTrace Extensions"
  				data-summary="Extensions on DDTrace"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DDTrace Extensions" class="fth-integration-name">DDTrace Extensions</div>
                            <div title="Extensions on DDTrace" class="fth-integration-desc">Extensions on DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,GOLANG,APM,TRACING"
  				data-name="DDTrace Golang"
  				data-summary="Tracing Golang application with DDTrace"
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
                            <div title="Tracing Golang application with DDTrace" class="fth-integration-desc">Tracing Golang application with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,JAVA,APM,TRACING"
  				data-name="DDTrace Java"
  				data-summary="Tracing Java application with DDTrace"
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
                            <div title="Tracing Java application with DDTrace" class="fth-integration-desc">Tracing Java application with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,JAVA"
  				data-name="DDTrace JMX"
  				data-summary="Export JVM metrics with DDTrace JMX"
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
                            <div title="Export JVM metrics with DDTrace JMX" class="fth-integration-desc">Export JVM metrics with DDTrace JMX</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,NODEJS,APM,TRACING"
  				data-name="DDTrace NodeJS"
  				data-summary="Tracing NodeJS applications with DDTrace"
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
                            <div title="Tracing NodeJS applications with DDTrace" class="fth-integration-desc">Tracing NodeJS applications with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,PHP,TRACING,APM"
  				data-name="DDTrace PHP"
  				data-summary="Tracing PHP applications with DDTrace"
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
                            <div title="Tracing PHP applications with DDTrace" class="fth-integration-desc">Tracing PHP applications with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,PYTHON,APM,TRACING"
  				data-name="DDTrace Python"
  				data-summary="Tracing Python applications with DDTrace"
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
                            <div title="Tracing Python applications with DDTrace" class="fth-integration-desc">Tracing Python applications with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,RUBY,APM,TRACING"
  				data-name="DDTrace Ruby"
  				data-summary="Tracing Ruby applications with DDTrace"
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
                            <div title="Tracing Ruby applications with DDTrace" class="fth-integration-desc">Tracing Ruby applications with DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING,DDTRACE"
  				data-name="DDTrace"
  				data-summary="Receive APM data from DDTrace"
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
                            <div title="Receive APM data from DDTrace" class="fth-integration-desc">Receive APM data from DDTrace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="TESTING,NETWORK"
  				data-name="Diatesting"
  				data-summary="Obtain network performance through network dialing test"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Diatesting" class="fth-integration-name">Diatesting</div>
                            <div title="Obtain network performance through network dialing test" class="fth-integration-desc">Obtain network performance through network dialing test</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="TESTING,NETWORK"
  				data-name="Customize Dialtesting"
  				data-summary="Customize your dialtesting task with local configurations"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Customize Dialtesting" class="fth-integration-name">Customize Dialtesting</div>
                            <div title="Customize your dialtesting task with local configurations" class="fth-integration-desc">Customize your dialtesting task with local configurations</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Disk"
  				data-summary="Collect metrics of disk"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/disk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Disk" class="fth-integration-name">Disk</div>
                            <div title="Collect metrics of disk" class="fth-integration-desc">Collect metrics of disk</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Disk IO"
  				data-summary="Collect metrics of disk io"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/diskio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Disk IO" class="fth-integration-name">Disk IO</div>
                            <div title="Collect metrics of disk io" class="fth-integration-desc">Collect metrics of disk io</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="DataKit metrics"
  				data-summary="Collect DataKit metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="DataKit metrics" class="fth-integration-name">DataKit metrics</div>
                            <div title="Collect DataKit metrics" class="fth-integration-desc">Collect DataKit metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Dameng Database (DM8)"
  				data-summary="Collect operational Metrics information from Dameng Database"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Dameng Database (DM8)" class="fth-integration-name">Dameng Database (DM8)</div>
                            <div title="Collect operational Metrics information from Dameng Database" class="fth-integration-desc">Collect operational Metrics information from Dameng Database</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="CONTAINERS"
  				data-name="Docker"
  				data-summary="Collect metrics, objects, and log data from Docker Containers"
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
                            <div title="Collect metrics, objects, and log data from Docker Containers" class="fth-integration-desc">Collect metrics, objects, and log data from Docker Containers</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Oriente THS (TongHttpServer)"
  				data-summary="Collect running Metrics information of Oriente THS (TongHttpServer)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Oriente THS (TongHttpServer)" class="fth-integration-name">Oriente THS (TongHttpServer)</div>
                            <div title="Collect running Metrics information of Oriente THS (TongHttpServer)" class="fth-integration-desc">Collect running Metrics information of Oriente THS (TongHttpServer)</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Orienteer TWeb (TongWeb)"
  				data-summary="Collect Orienteer TWeb (TongWeb) runtime Metrics and APM information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Orienteer TWeb (TongWeb)" class="fth-integration-name">Orienteer TWeb (TongWeb)</div>
                            <div title="Collect Orienteer TWeb (TongWeb) runtime Metrics and APM information" class="fth-integration-desc">Collect Orienteer TWeb (TongWeb) runtime Metrics and APM information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Doris"
  				data-summary="Collect metrics of Doris"
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
                            <div title="Collect metrics of Doris" class="fth-integration-desc">Collect metrics of Doris</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect related Metrics, Tracing, Logging, and Profiling information for .NET applications."
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
                            <div title="Collect related Metrics, Tracing, Logging, and Profiling information for .NET applications." class="fth-integration-desc">Collect related Metrics, Tracing, Logging, and Profiling information for .NET applications.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to the Druid database connection pool"
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
                            <div title="Collect metrics related to the Druid database connection pool" class="fth-integration-desc">Collect metrics related to the Druid database connection pool</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Linux network data through eBPF"
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
                            <div title="Collect Linux network data through eBPF" class="fth-integration-desc">Collect Linux network data through eBPF</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING,EBPF"
  				data-name="eBPF Tracing"
  				data-summary="Associate eBPF span and generate trace"
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
                            <div title="Associate eBPF span and generate trace" class="fth-integration-desc">Associate eBPF span and generate trace</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="ElasticSearch"
  				data-summary="Collect ElasticSearch metrics"
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
                            <div title="Collect ElasticSearch metrics" class="fth-integration-desc">Collect ElasticSearch metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect EMQX collection, topics, subscriptions, message, and packet related Metrics information"
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
                            <div title="Collect EMQX collection, topics, subscriptions, message, and packet related Metrics information" class="fth-integration-desc">Collect EMQX collection, topics, subscriptions, message, and packet related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE"
  				data-name="etcd"
  				data-summary="Collect etcd metrics"
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
                            <div title="Collect etcd metrics" class="fth-integration-desc">Collect etcd metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Exchange related Metrics information"
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
                            <div title="Collect Exchange related Metrics information" class="fth-integration-desc">Collect Exchange related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Start external program for collection"
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
                            <div title="Start external program for collection" class="fth-integration-desc">Start external program for collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../feishu_im"
  				data-tags=""
  				data-name="Lark and Exception Tracking Integration"
  				data-summary="To get new issues from exception tracking more timely and conveniently, we can create a Lark, DingTalk or WeChat Work bot in the internal group to receive new issue alerts from exception tracking, or new reply alerts. This can help us handle issues in a timely manner. We can also quickly respond to issues by @bot, which can improve our exception handling efficiency."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/feishu_im/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Lark and Exception Tracking Integration" class="fth-integration-name">Lark and Exception Tracking Integration</div>
                            <div title="To get new issues from exception tracking more timely and conveniently, we can create a Lark, DingTalk or WeChat Work bot in the internal group to receive new issue alerts from exception tracking, or new reply alerts. This can help us handle issues in a timely manner. We can also quickly respond to issues by @bot, which can improve our exception handling efficiency." class="fth-integration-desc">To get new issues from exception tracking more timely and conveniently, we can create a Lark, DingTalk or WeChat Work bot in the internal group to receive new issue alerts from exception tracking, or new reply alerts. This can help us handle issues in a timely manner. We can also quickly respond to issues by @bot, which can improve our exception handling efficiency.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE"
  				data-name="Flink"
  				data-summary="Collect Flink metrics"
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
                            <div title="Collect Flink metrics" class="fth-integration-desc">Collect Flink metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect logs via Fluent Bit"
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
                            <div title="Collect logs via Fluent Bit" class="fth-integration-desc">Collect logs via Fluent Bit</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Fluentd logs"
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
                            <div title="Collect Fluentd logs" class="fth-integration-desc">Collect Fluentd logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect resource metrics such as CPU, memory, disk, and network for GCP Compute Engine virtual machines"
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
                            <div title="Collect resource metrics such as CPU, memory, disk, and network for GCP Compute Engine virtual machines" class="fth-integration-desc">Collect resource metrics such as CPU, memory, disk, and network for GCP Compute Engine virtual machines</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect GitLab metrics and logs"
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
                            <div title="Collect GitLab metrics and logs" class="fth-integration-desc">Collect GitLab metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Metrics, APM, and LOG information from Golang applications"
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
                            <div title="Collect Metrics, APM, and LOG information from Golang applications" class="fth-integration-desc">Collect Metrics, APM, and LOG information from Golang applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="GPU"
  				data-summary="Collect NVIDIA GPU metrics and logs"
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
                            <div title="Collect NVIDIA GPU metrics and logs" class="fth-integration-desc">Collect NVIDIA GPU metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Grafana <<< custom_key.brand_name >>> Datasource"
  				data-summary="Grafana connects to the data provided by <<< custom_key.brand_name >>> Datasource"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/grafana_datasource/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Grafana <<< custom_key.brand_name >>> Datasource" class="fth-integration-name">Grafana <<< custom_key.brand_name >>> Datasource</div>
                            <div title="Grafana connects to the data provided by <<< custom_key.brand_name >>> Datasource" class="fth-integration-desc">Grafana connects to the data provided by <<< custom_key.brand_name >>> Datasource</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY"
  				data-name="Graphite Exporter"
  				data-summary="Collect Graphite Exporter exposed by Graphite Exporter"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/graphite/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Graphite Exporter" class="fth-integration-name">Graphite Exporter</div>
                            <div title="Collect Graphite Exporter exposed by Graphite Exporter" class="fth-integration-desc">Collect Graphite Exporter exposed by Graphite Exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect GreenPlum Metrics information"
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
                            <div title="Collect GreenPlum Metrics information" class="fth-integration-desc">Collect GreenPlum Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect HDFS datanode Metrics information"
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
                            <div title="Collect HDFS datanode Metrics information" class="fth-integration-desc">Collect HDFS datanode Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect HDFS namenode Metrics information"
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
                            <div title="Collect HDFS namenode Metrics information" class="fth-integration-desc">Collect HDFS namenode Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Yarn NodeManager metrics information"
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
                            <div title="Collect Yarn NodeManager metrics information" class="fth-integration-desc">Collect Yarn NodeManager metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics information from Yarn ResourceManager"
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
                            <div title="Collect metrics information from Yarn ResourceManager" class="fth-integration-desc">Collect metrics information from Yarn ResourceManager</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Haproxy Metrics information"
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
                            <div title="Collect Haproxy Metrics information" class="fth-integration-desc">Collect Haproxy Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect HBase Master Metrics information"
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
                            <div title="Collect HBase Master Metrics information" class="fth-integration-desc">Collect HBase Master Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect HBase Region Metrics Information"
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
                            <div title="Collect HBase Region Metrics Information" class="fth-integration-desc">Collect HBase Region Metrics Information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Health Check"
  				data-summary="Regularly check the host process and network health status"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/healthcheck/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Health Check" class="fth-integration-name">Health Check</div>
                            <div title="Regularly check the host process and network health status" class="fth-integration-desc">Regularly check the host process and network health status</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Process"
  				data-summary="Collect host process metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/process/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Process" class="fth-integration-name">Process</div>
                            <div title="Collect host process metrics" class="fth-integration-desc">Collect host process metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Host Directory"
  				data-summary="Collect metrics from file directories"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostdir/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Host Directory" class="fth-integration-name">Host Directory</div>
                            <div title="Collect metrics from file directories" class="fth-integration-desc">Collect metrics from file directories</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Host Object"
  				data-summary="Collect Basic Host Information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostobject/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Host Object" class="fth-integration-name">Host Object</div>
                            <div title="Collect Basic Host Information" class="fth-integration-desc">Collect Basic Host Information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud FunctionGraph"
  				data-summary="The displayed metrics for Huawei Cloud FunctionGraph include the number of calls, number of errors, number of rejections, concurrency count, reserved instance count, and run time (including maximum run time, minimum run time, and average run time), which reflect the operational status of the FunctionGraph function."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_functiongraph/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud FunctionGraph" class="fth-integration-name">Huawei Cloud FunctionGraph</div>
                            <div title="The displayed metrics for Huawei Cloud FunctionGraph include the number of calls, number of errors, number of rejections, concurrency count, reserved instance count, and run time (including maximum run time, minimum run time, and average run time), which reflect the operational status of the FunctionGraph function." class="fth-integration-desc">The displayed metrics for Huawei Cloud FunctionGraph include the number of calls, number of errors, number of rejections, concurrency count, reserved instance count, and run time (including maximum run time, minimum run time, and average run time), which reflect the operational status of the FunctionGraph function.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="HUAWEI AS"
  				data-summary="The key performance Metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load, all of which are critical Metrics for evaluating and optimizing the performance of an auto-scaling system."
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
                            <div title="The key performance Metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load, all of which are critical Metrics for evaluating and optimizing the performance of an auto-scaling system." class="fth-integration-desc">The key performance Metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load, all of which are critical Metrics for evaluating and optimizing the performance of an auto-scaling system.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud CBR"
  				data-summary="The displayed Metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These Metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_sys_cbr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud CBR" class="fth-integration-name">Huawei Cloud CBR</div>
                            <div title="The displayed Metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These Metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management." class="fth-integration-desc">The displayed Metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These Metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DDM"
  				data-summary="The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These Metrics reflect the performance and reliability of DDMS when handling large-scale messaging and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huaweiyun_SYS_DDMS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DDM" class="fth-integration-name">Huawei Cloud DDM</div>
                            <div title="The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These Metrics reflect the performance and reliability of DDMS when handling large-scale messaging and real-time data streams." class="fth-integration-desc">The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These Metrics reflect the performance and reliability of DDMS when handling large-scale messaging and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud API"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_apic/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud API" class="fth-integration-name">Huawei Cloud API</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud ASM Tracing TO <<< custom_key.brand_name >>>"
  				data-summary="Output tracing data from Huawei Cloud ASM to <<< custom_key.brand_name >>> for viewing and analysis."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_asm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud ASM Tracing TO <<< custom_key.brand_name >>>" class="fth-integration-name">Huawei Cloud ASM Tracing TO <<< custom_key.brand_name >>></div>
                            <div title="Output tracing data from Huawei Cloud ASM to <<< custom_key.brand_name >>> for viewing and analysis." class="fth-integration-desc">Output tracing data from Huawei Cloud ASM to <<< custom_key.brand_name >>> for viewing and analysis.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Collect Huawei Cloud CCE Metrics Data Using <<< custom_key.brand_name >>>"
  				data-summary="<<< custom_key.brand_name >>> supports monitoring the operation status and service capabilities of various resources in CCE, including CONTAINERS, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_cce/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Collect Huawei Cloud CCE Metrics Data Using <<< custom_key.brand_name >>>" class="fth-integration-name">Collect Huawei Cloud CCE Metrics Data Using <<< custom_key.brand_name >>></div>
                            <div title="<<< custom_key.brand_name >>> supports monitoring the operation status and service capabilities of various resources in CCE, including CONTAINERS, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc." class="fth-integration-desc"><<< custom_key.brand_name >>> supports monitoring the operation status and service capabilities of various resources in CCE, including CONTAINERS, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud Search Service CSS for Elasticsearch"
  				data-summary="Collect monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_css_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud Search Service CSS for Elasticsearch" class="fth-integration-name">Huawei Cloud Search Service CSS for Elasticsearch</div>
                            <div title="Collect monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch" class="fth-integration-desc">Collect monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DCAAS Cloud Direct Connect"
  				data-summary="Collect Huawei Cloud DCAAS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dcaas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DCAAS Cloud Direct Connect" class="fth-integration-name">Huawei Cloud DCAAS Cloud Direct Connect</div>
                            <div title="Collect Huawei Cloud DCAAS Metrics data" class="fth-integration-desc">Collect Huawei Cloud DCAAS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DCS"
  				data-summary="Collect Huawei Cloud DCS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dcs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DCS" class="fth-integration-name">Huawei Cloud DCS</div>
                            <div title="Collect Huawei Cloud DCS Metrics data" class="fth-integration-desc">Collect Huawei Cloud DCS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DDS"
  				data-summary="Collect Huawei Cloud DDS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dds/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DDS" class="fth-integration-name">Huawei Cloud DDS</div>
                            <div title="Collect Huawei Cloud DDS Metrics data" class="fth-integration-desc">Collect Huawei Cloud DDS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DIS"
  				data-summary="Collect Huawei Cloud DIS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DIS" class="fth-integration-name">Huawei Cloud DIS</div>
                            <div title="Collect Huawei Cloud DIS Metrics data" class="fth-integration-desc">Collect Huawei Cloud DIS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud ECS"
  				data-summary="Collect Huawei Cloud ECS monitoring Metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawe_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud ECS" class="fth-integration-name">Huawei Cloud ECS</div>
                            <div title="Collect Huawei Cloud ECS monitoring Metrics" class="fth-integration-desc">Collect Huawei Cloud ECS monitoring Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud EIP"
  				data-summary="Collect Huawei Cloud EIP Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud EIP" class="fth-integration-name">Huawei Cloud EIP</div>
                            <div title="Collect Huawei Cloud EIP Metrics data" class="fth-integration-desc">Collect Huawei Cloud EIP Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud ELB"
  				data-summary="Collect Huawei Cloud ELB monitoring Metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud ELB" class="fth-integration-name">Huawei Cloud ELB</div>
                            <div title="Collect Huawei Cloud ELB monitoring Metrics" class="fth-integration-desc">Collect Huawei Cloud ELB monitoring Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud GaussDB-Cassandra"
  				data-summary="The displayed Metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These Metrics reflect the performance and reliability of GaussDB-Cassandra when handling large-scale distributed data storage and access."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud GaussDB-Cassandra" class="fth-integration-name">Huawei Cloud GaussDB-Cassandra</div>
                            <div title="The displayed Metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These Metrics reflect the performance and reliability of GaussDB-Cassandra when handling large-scale distributed data storage and access." class="fth-integration-desc">The displayed Metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These Metrics reflect the performance and reliability of GaussDB-Cassandra when handling large-scale distributed data storage and access.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud GaussDB for MySQL"
  				data-summary="GaussDB for MySQL, including cpu, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_for_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud GaussDB for MySQL" class="fth-integration-name">Huawei Cloud GaussDB for MySQL</div>
                            <div title="GaussDB for MySQL, including cpu, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics." class="fth-integration-desc">GaussDB for MySQL, including cpu, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud GaussDB-Influx"
  				data-summary="The display Metrics of Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These Metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_influx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud GaussDB-Influx" class="fth-integration-name">Huawei Cloud GaussDB-Influx</div>
                            <div title="The display Metrics of Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These Metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries." class="fth-integration-desc">The display Metrics of Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These Metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud GaussDB-Redis"
  				data-summary="The displayed Metrics for Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud GaussDB-Redis" class="fth-integration-name">Huawei Cloud GaussDB-Redis</div>
                            <div title="The displayed Metrics for Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching." class="fth-integration-desc">The displayed Metrics for Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud GaussDB SYS.GAUSSDBV5"
  				data-summary="Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data for cpu, memory, disk, deadlock, and SQL response time metrics."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_sys.gaussdbv5/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud GaussDB SYS.GAUSSDBV5" class="fth-integration-name">Huawei Cloud GaussDB SYS.GAUSSDBV5</div>
                            <div title="Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data for cpu, memory, disk, deadlock, and SQL response time metrics." class="fth-integration-desc">Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data for cpu, memory, disk, deadlock, and SQL response time metrics.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DMS Kafka"
  				data-summary="Collect Huawei Cloud DMS Kafka Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DMS Kafka" class="fth-integration-name">Huawei Cloud DMS Kafka</div>
                            <div title="Collect Huawei Cloud DMS Kafka Metrics data" class="fth-integration-desc">Collect Huawei Cloud DMS Kafka Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud MongoDB"
  				data-summary="Collecting Huawei Cloud MongoDB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud MongoDB" class="fth-integration-name">Huawei Cloud MongoDB</div>
                            <div title="Collecting Huawei Cloud MongoDB Metrics data" class="fth-integration-desc">Collecting Huawei Cloud MongoDB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud OBS"
  				data-summary="Collect Huawei Cloud OBS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_obs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud OBS" class="fth-integration-name">Huawei Cloud OBS</div>
                            <div title="Collect Huawei Cloud OBS Metrics data" class="fth-integration-desc">Collect Huawei Cloud OBS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DMS RabbitMQ"
  				data-summary="Collect Huawei Cloud DMS RabbitMQ Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DMS RabbitMQ" class="fth-integration-name">Huawei Cloud DMS RabbitMQ</div>
                            <div title="Collect Huawei Cloud DMS RabbitMQ Metrics data" class="fth-integration-desc">Collect Huawei Cloud DMS RabbitMQ Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud RDS MariaDB"
  				data-summary="Collect Huawei Cloud RDS MariaDB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud RDS MariaDB" class="fth-integration-name">Huawei Cloud RDS MariaDB</div>
                            <div title="Collect Huawei Cloud RDS MariaDB Metrics data" class="fth-integration-desc">Collect Huawei Cloud RDS MariaDB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud RDS MYSQL"
  				data-summary="Collect Huawei Cloud RDS MYSQL data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud RDS MYSQL" class="fth-integration-name">Huawei Cloud RDS MYSQL</div>
                            <div title="Collect Huawei Cloud RDS MYSQL data" class="fth-integration-desc">Collect Huawei Cloud RDS MYSQL data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud RDS PostgreSQL"
  				data-summary="Collect Metrics data from Huawei Cloud RDS PostgreSQL"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud RDS PostgreSQL" class="fth-integration-name">Huawei Cloud RDS PostgreSQL</div>
                            <div title="Collect Metrics data from Huawei Cloud RDS PostgreSQL" class="fth-integration-desc">Collect Metrics data from Huawei Cloud RDS PostgreSQL</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud RDS SQLServer"
  				data-summary="Collect Huawei Cloud RDS SQLServer Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud RDS SQLServer" class="fth-integration-name">Huawei Cloud RDS SQLServer</div>
                            <div title="Collect Huawei Cloud RDS SQLServer Metrics data" class="fth-integration-desc">Collect Huawei Cloud RDS SQLServer Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud DMS RocketMQ"
  				data-summary="Collect Metrics data from Huawei Cloud DMS RocketMQ"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud DMS RocketMQ" class="fth-integration-name">Huawei Cloud DMS RocketMQ</div>
                            <div title="Collect Metrics data from Huawei Cloud DMS RocketMQ" class="fth-integration-desc">Collect Metrics data from Huawei Cloud DMS RocketMQ</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud ROMA"
  				data-summary="Collect Huawei Cloud ROMA Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_roma/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud ROMA" class="fth-integration-name">Huawei Cloud ROMA</div>
                            <div title="Collect Huawei Cloud ROMA Metrics data" class="fth-integration-desc">Collect Huawei Cloud ROMA Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud WAF Web Application Firewall"
  				data-summary="Collect Huawei Cloud WAF Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_waf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud WAF Web Application Firewall" class="fth-integration-name">Huawei Cloud WAF Web Application Firewall</div>
                            <div title="Collect Huawei Cloud WAF Metrics data" class="fth-integration-desc">Collect Huawei Cloud WAF Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../huaweiyun_SYS_DDMS"
  				data-tags="Huawei Cloud"
  				data-name="Huawei Cloud SYS.DDMS Monitoring View"
  				data-summary="The Huawei Cloud SYS.DDMS monitoring view displays indicators including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of DDMS in handling large-scale message delivery and real-time data flow."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huaweiyun_SYS_DDMS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Huawei Cloud SYS.DDMS Monitoring View" class="fth-integration-name">Huawei Cloud SYS.DDMS Monitoring View</div>
                            <div title="The Huawei Cloud SYS.DDMS monitoring view displays indicators including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of DDMS in handling large-scale message delivery and real-time data flow." class="fth-integration-desc">The Huawei Cloud SYS.DDMS monitoring view displays indicators including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of DDMS in handling large-scale message delivery and real-time data flow.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect IIS metrics"
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
                            <div title="Collect IIS metrics" class="fth-integration-desc">Collect IIS metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="iLogtail collects log information"
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
                            <div title="iLogtail collects log information" class="fth-integration-desc">iLogtail collects log information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="InfluxDB"
  				data-summary="Collect InfluxDB metrics"
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
                            <div title="Collect InfluxDB metrics" class="fth-integration-desc">Collect InfluxDB metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collection of Ingress Nginx (Prometheus) related Metrics information"
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
                            <div title="Collection of Ingress Nginx (Prometheus) related Metrics information" class="fth-integration-desc">Collection of Ingress Nginx (Prometheus) related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect IPMI metrics"
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
                            <div title="Collect IPMI metrics" class="fth-integration-desc">Collect IPMI metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident - DingTalk"
  				data-summary="<<< custom_key.brand_name >>> Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply via DingTalk, which can then be transmitted back to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dingtalk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Incident - DingTalk" class="fth-integration-name">Incident - DingTalk</div>
                            <div title="<<< custom_key.brand_name >>> Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply via DingTalk, which can then be transmitted back to <<< custom_key.brand_name >>>" class="fth-integration-desc"><<< custom_key.brand_name >>> Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply via DingTalk, which can then be transmitted back to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident - Lark"
  				data-summary="<<< custom_key.brand_name >>> Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to <<< custom_key.brand_name >>>."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/feishu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Incident - Lark" class="fth-integration-name">Incident - Lark</div>
                            <div title="<<< custom_key.brand_name >>> Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to <<< custom_key.brand_name >>>." class="fth-integration-desc"><<< custom_key.brand_name >>> Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Istio performance Metrics, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc."
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
                            <div title="Display of Istio performance Metrics, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc." class="fth-integration-desc">Display of Istio performance Metrics, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="JAEGER,APM,TRACING"
  				data-name="Jaeger"
  				data-summary="Receive Jaeger APM Data"
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
                            <div title="Receive Jaeger APM Data" class="fth-integration-desc">Receive Jaeger APM Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Get metrics, APM data, and LOG information from JAVA applications"
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
                            <div title="Get metrics, APM data, and LOG information from JAVA applications" class="fth-integration-desc">Get metrics, APM data, and LOG information from JAVA applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Monitor the usage behavior of browser users via the JavaScript (Web) method."
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
                            <div title="Monitor the usage behavior of browser users via the JavaScript (Web) method." class="fth-integration-desc">Monitor the usage behavior of browser users via the JavaScript (Web) method.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Jenkins metrics and logs"
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
                            <div title="Collect Jenkins metrics and logs" class="fth-integration-desc">Collect Jenkins metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc."
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
                            <div title="JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc." class="fth-integration-desc">JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect information on component metrics related to JuiceFS data size, IO, transactions, objects, clients, etc."
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
                            <div title="Collect information on component metrics related to JuiceFS data size, IO, transactions, objects, clients, etc." class="fth-integration-desc">Collect information on component metrics related to JuiceFS data size, IO, transactions, objects, clients, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect the JVM metrics"
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
                            <div title="Collect the JVM metrics" class="fth-integration-desc">Collect the JVM metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc."
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
                            <div title="JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc." class="fth-integration-desc">JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, class loading counts, etc."
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
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, class loading counts, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, class loading counts, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, number of class loads, etc."
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
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, number of class loads, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, number of class loads, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, class loading numbers, etc."
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
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, class loading numbers, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, class loading numbers, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MIDDLEWARE,MESSAGE QUEUES"
  				data-name="Kafka"
  				data-summary="Collect metrics of Kafka"
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
                            <div title="Collect metrics of Kafka" class="fth-integration-desc">Collect metrics of Kafka</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MESSAGE QUEUES,LOG"
  				data-name="KafkaMQ"
  				data-summary="Collect metrics and log data via Kafka"
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
                            <div title="Collect metrics and log data via Kafka" class="fth-integration-desc">Collect metrics and log data via Kafka</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Kong Metrics and Log Information"
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
                            <div title="Collect Kong Metrics and Log Information" class="fth-integration-desc">Collect Kong Metrics and Log Information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="By tracking the runtime metrics of kube-proxy, it helps to understand information such as the load of the network proxy, response time, synchronization status, etc."
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
                            <div title="By tracking the runtime metrics of kube-proxy, it helps to understand information such as the load of the network proxy, response time, synchronization status, etc." class="fth-integration-desc">By tracking the runtime metrics of kube-proxy, it helps to understand information such as the load of the network proxy, response time, synchronization status, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve the resource utilization of the cluster and the performance of applications"
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
                            <div title="By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve the resource utilization of the cluster and the performance of applications" class="fth-integration-desc">By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve the resource utilization of the cluster and the performance of applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect real-time information about cluster resources using Kube State Metrics"
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
                            <div title="Collect real-time information about cluster resources using Kube State Metrics" class="fth-integration-desc">Collect real-time information about cluster resources using Kube State Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect KubeCost Metrics information"
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
                            <div title="Collect KubeCost Metrics information" class="fth-integration-desc">Collect KubeCost Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Kubelet Metrics information"
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
                            <div title="Collect Kubelet Metrics information" class="fth-integration-desc">Collect Kubelet Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics information related to the Kubernetes API Server"
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
                            <div title="Collect metrics information related to the Kubernetes API Server" class="fth-integration-desc">Collect metrics information related to the Kubernetes API Server</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Kubernetes CRD Extended Collection"
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
                            <div title="Kubernetes CRD Extended Collection" class="fth-integration-name">Kubernetes CRD Extended Collection</div>
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
  				data-summary="Collect Prometheus metrics among Kubernetes Pod"
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
                            <div title="Collect Prometheus metrics among Kubernetes Pod" class="fth-integration-desc">Collect Prometheus metrics among Kubernetes Pod</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Kubernetes Prometheus CRD"
  				data-summary="Collecting on Prometheus-Operator CRD"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes Prometheus CRD" class="fth-integration-name">Kubernetes Prometheus CRD</div>
                            <div title="Collecting on Prometheus-Operator CRD" class="fth-integration-desc">Collecting on Prometheus-Operator CRD</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Kubernetes Audit Log Collection"
  				data-summary="Kubernetes Audit Log Collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Kubernetes Audit Log Collection" class="fth-integration-name">Kubernetes Audit Log Collection</div>
                            <div title="Kubernetes Audit Log Collection" class="fth-integration-desc">Kubernetes Audit Log Collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Auto discovery and collecting Prometheus exported metrics among Kubernetes"
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
                            <div title="Auto discovery and collecting Prometheus exported metrics among Kubernetes" class="fth-integration-desc">Auto discovery and collecting Prometheus exported metrics among Kubernetes</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Optimize the use of LangChain: timely sampling and performance and cost metrics."
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
                            <div title="Optimize the use of LangChain: timely sampling and performance and cost metrics." class="fth-integration-desc">Optimize the use of LangChain: timely sampling and performance and cost metrics.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="KUBERNETES,LOG,CONTAINER"
  				data-name="Sidecar for Pod Logging"
  				data-summary="Collect pod logging via Sidecar"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Sidecar for Pod Logging" class="fth-integration-name">Sidecar for Pod Logging</div>
                            <div title="Collect pod logging via Sidecar" class="fth-integration-desc">Collect pod logging via Sidecar</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="KUBERNETES,LOG,CONTAINER"
  				data-name="Log Forward Server"
  				data-summary="Collect log data in Pod through sidecar method"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logfwd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Log Forward Server" class="fth-integration-name">Log Forward Server</div>
                            <div title="Collect log data in Pod through sidecar method" class="fth-integration-desc">Collect log data in Pod through sidecar method</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="LOG"
  				data-name="Log Collector"
  				data-summary="Collect log data on the host"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logging/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Log Collector" class="fth-integration-name">Log Collector</div>
                            <div title="Collect log data on the host" class="fth-integration-desc">Collect log data on the host</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="LOG"
  				data-name="Socket Logging"
  				data-summary="Accept Java/Go/Python logging framework remotely"
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
                            <div title="Accept Java/Go/Python logging framework remotely" class="fth-integration-desc">Accept Java/Go/Python logging framework remotely</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect log information via Logstash"
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
                            <div title="Collect log information via Logstash" class="fth-integration-desc">Collect log information via Logstash</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="LOG"
  				data-name="Log Streaming"
  				data-summary="Report log data via HTTP"
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
                            <div title="Report log data via HTTP" class="fth-integration-desc">Report log data via HTTP</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Lsblk"
  				data-summary="Collect metrics of block device"
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
                            <div title="Collect metrics of block device" class="fth-integration-desc">Collect metrics of block device</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Memory"
  				data-summary="Collect metrics of host memory"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Memory" class="fth-integration-name">Memory</div>
                            <div title="Collect metrics of host memory" class="fth-integration-desc">Collect metrics of host memory</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="CACHING,MIDDLEWARE"
  				data-name="Memcached"
  				data-summary="Collect memcached metrics data"
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
                            <div title="Collect memcached metrics data" class="fth-integration-desc">Collect memcached metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Milvus Vector Database"
  				data-summary="Collect metrics information related to Milvus vector database"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/milvus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Milvus Vector Database" class="fth-integration-name">Milvus Vector Database</div>
                            <div title="Collect metrics information related to Milvus vector database" class="fth-integration-desc">Collect metrics information related to Milvus vector database</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collection of MinIO related Metrics information"
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
                            <div title="Collection of MinIO related Metrics information" class="fth-integration-desc">Collection of MinIO related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect relevant Metrics information for MinIO"
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
                            <div title="Collect relevant Metrics information for MinIO" class="fth-integration-desc">Collect relevant Metrics information for MinIO</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="MongoDB"
  				data-summary="Collect mongodb metrics data"
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
                            <div title="Collect mongodb metrics data" class="fth-integration-desc">Collect mongodb metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident Events Integration with Jira"
  				data-summary="When our applications or systems experience incidents, they usually need to be handled promptly to ensure normal system operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira to create issues, we gain better capabilities for managing and tracking incident events, thereby ensuring smoother system operations. Additionally, this method also helps us better analyze and solve problems, enhancing the stability and reliability of the system."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/monitor_jira/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Incident Events Integration with Jira" class="fth-integration-name">Incident Events Integration with Jira</div>
                            <div title="When our applications or systems experience incidents, they usually need to be handled promptly to ensure normal system operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira to create issues, we gain better capabilities for managing and tracking incident events, thereby ensuring smoother system operations. Additionally, this method also helps us better analyze and solve problems, enhancing the stability and reliability of the system." class="fth-integration-desc">When our applications or systems experience incidents, they usually need to be handled promptly to ensure normal system operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira to create issues, we gain better capabilities for managing and tracking incident events, thereby ensuring smoother system operations. Additionally, this method also helps us better analyze and solve problems, enhancing the stability and reliability of the system.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Receive MQTT protocol data"
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
                            <div title="Receive MQTT protocol data" class="fth-integration-desc">Receive MQTT protocol data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="MySQL"
  				data-summary="Collect MySQL metrics and logs"
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
                            <div title="Collect MySQL metrics and logs" class="fth-integration-desc">Collect MySQL metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect information related to Nacos Metrics"
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
                            <div title="Collect information related to Nacos Metrics" class="fth-integration-desc">Collect information related to Nacos Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Neo4j"
  				data-summary="Collect Neo4j server metrics"
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
                            <div title="Collect Neo4j server metrics" class="fth-integration-desc">Collect Neo4j server metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Network"
  				data-summary="Collect NIC metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/net/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Network" class="fth-integration-name">Network</div>
                            <div title="Collect NIC metrics data" class="fth-integration-desc">Collect NIC metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="NETWORK"
  				data-name="NetFlow"
  				data-summary="NetFlow collector can be used to visualize and monitor NetFlow-enabled device."
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
                            <div title="NetFlow collector can be used to visualize and monitor NetFlow-enabled device." class="fth-integration-desc">NetFlow collector can be used to visualize and monitor NetFlow-enabled device.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="NETWORK,HOST"
  				data-name="NetStat"
  				data-summary="Collect NIC traffic metrics data"
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
                            <div title="Collect NIC traffic metrics data" class="fth-integration-desc">Collect NIC traffic metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,NEWRELIC,TRACING"
  				data-name="New Relic"
  				data-summary="Receive data from New Relic Agent"
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
                            <div title="Receive data from New Relic Agent" class="fth-integration-desc">Receive data from New Relic Agent</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="NFS"
  				data-summary="Collect metrics of NFS"
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
                            <div title="Collect metrics of NFS" class="fth-integration-desc">Collect metrics of NFS</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="WEB SERVER,MIDDLEWARE"
  				data-name="Nginx"
  				data-summary="Collect metrics of Nginx"
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
                            <div title="Collect metrics of Nginx" class="fth-integration-desc">Collect metrics of Nginx</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Nginx trace information"
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
                            <div title="Collect Nginx trace information" class="fth-integration-desc">Collect Nginx trace information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect HOST metrics information via Node Exporter"
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
                            <div title="Collect HOST metrics information via Node Exporter" class="fth-integration-desc">Collect HOST metrics information via Node Exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Obtain metrics, APM traces, and log information for NodeJs applications"
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
                            <div title="Obtain metrics, APM traces, and log information for NodeJs applications" class="fth-integration-desc">Obtain metrics, APM traces, and log information for NodeJs applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect cluster node Metrics and events via NPD"
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
                            <div title="Collect cluster node Metrics and events via NPD" class="fth-integration-desc">Collect cluster node Metrics and events via NPD</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MESSAGE QUEUES,MIDDLEWARE"
  				data-name="NSQ"
  				data-summary="Collect NSQ metrics"
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
                            <div title="Collect NSQ metrics" class="fth-integration-desc">Collect NSQ metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="OceanBase"
  				data-summary="Collect OceanBase metrics"
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
                            <div title="Collect OceanBase metrics" class="fth-integration-desc">Collect OceanBase metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics of OpenAI include total requests, response time, request volume, number of request errors, and consumed token count."
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
                            <div title="The displayed Metrics of OpenAI include total requests, response time, request volume, number of request errors, and consumed token count." class="fth-integration-desc">The displayed Metrics of OpenAI include total requests, response time, request volume, number of request errors, and consumed token count.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect OpenGauss Metrics information"
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
                            <div title="Collect OpenGauss Metrics information" class="fth-integration-desc">Collect OpenGauss Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="OTEL,APM"
  				data-name="OpenLIT"
  				data-summary="OpenLIT simplifies the development process of generative AI and large language models (LLMs), providing comprehensive observability support, and reports observability data to <<< custom_key.brand_name >>>."
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
                            <div title="OpenLIT simplifies the development process of generative AI and large language models (LLMs), providing comprehensive observability support, and reports observability data to <<< custom_key.brand_name >>>." class="fth-integration-desc">OpenLIT simplifies the development process of generative AI and large language models (LLMs), providing comprehensive observability support, and reports observability data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="GOLANG,OTEL,APM,TRACING"
  				data-name="OpenTelemetry Golang"
  				data-summary="Tracing Golang applications with OpenTelemetry"
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
                            <div title="Tracing Golang applications with OpenTelemetry" class="fth-integration-desc">Tracing Golang applications with OpenTelemetry</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="JAVA,OTEL,APM,TRACING"
  				data-name="OpenTelemetry Java"
  				data-summary="Tracing Java applications with OpenTelemetry"
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
                            <div title="Tracing Java applications with OpenTelemetry" class="fth-integration-desc">Tracing Java applications with OpenTelemetry</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PYTHON,OTEL,APM"
  				data-name="OpenTelemetry Python"
  				data-summary="OpenTelemetry Python Integration"
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
                            <div title="OpenTelemetry Python Integration" class="fth-integration-desc">OpenTelemetry Python Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="OTEL,APM,TRACING"
  				data-name="OpenTelemetry"
  				data-summary="Collect OpenTelemetry metric, log and APM data"
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
                            <div title="Collect OpenTelemetry metric, log and APM data" class="fth-integration-desc">Collect OpenTelemetry metric, log and APM data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Oracle"
  				data-summary="Collect Oracle Metric"
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
                            <div title="Collect Oracle Metric" class="fth-integration-desc">Collect Oracle Metric</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="OTEL,APM,TRACING"
  				data-name="OpenTelemetry Extensions"
  				data-summary="<<<custom_key.brand_name>>> added more OpenTelemetry plugins"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry Extensions" class="fth-integration-name">OpenTelemetry Extensions</div>
                            <div title="<<<custom_key.brand_name>>> added more OpenTelemetry plugins" class="fth-integration-desc"><<<custom_key.brand_name>>> added more OpenTelemetry plugins</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="OpenTelemetry Exportor for <<<custom_key.brand_name>>>"
  				data-summary="Export OpenTelemetry data to GuanCe Cloud directly"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="OpenTelemetry Exportor for <<<custom_key.brand_name>>>" class="fth-integration-name">OpenTelemetry Exportor for <<<custom_key.brand_name>>></div>
                            <div title="Export OpenTelemetry data to GuanCe Cloud directly" class="fth-integration-desc">Export OpenTelemetry data to GuanCe Cloud directly</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident Events Integration with PagerDuty"
  				data-summary="When our applications or systems experience incidents, they typically need to be addressed promptly to ensure normal system operations. To better manage and track incident events, we can send these events to PagerDuty to create incidents, allowing us to track, analyze, and resolve these issues within PagerDuty. By quickly sending incident events to PagerDuty to create incidents, we gain better capabilities for managing and tracking incident events, thereby ensuring the normal operation of the system more effectively. Additionally, this method helps us better analyze and resolve problems, enhancing the stability and reliability of the system."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pagerduty/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Incident Events Integration with PagerDuty" class="fth-integration-name">Incident Events Integration with PagerDuty</div>
                            <div title="When our applications or systems experience incidents, they typically need to be addressed promptly to ensure normal system operations. To better manage and track incident events, we can send these events to PagerDuty to create incidents, allowing us to track, analyze, and resolve these issues within PagerDuty. By quickly sending incident events to PagerDuty to create incidents, we gain better capabilities for managing and tracking incident events, thereby ensuring the normal operation of the system more effectively. Additionally, this method helps us better analyze and resolve problems, enhancing the stability and reliability of the system." class="fth-integration-desc">When our applications or systems experience incidents, they typically need to be addressed promptly to ensure normal system operations. To better manage and track incident events, we can send these events to PagerDuty to create incidents, allowing us to track, analyze, and resolve these issues within PagerDuty. By quickly sending incident events to PagerDuty to create incidents, we gain better capabilities for managing and tracking incident events, thereby ensuring the normal operation of the system more effectively. Additionally, this method helps us better analyze and resolve problems, enhancing the stability and reliability of the system.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Get metrics, APM, and LOG information for PHP applications"
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
                            <div title="Get metrics, APM, and LOG information for PHP applications" class="fth-integration-desc">Get metrics, APM, and LOG information for PHP applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,GOLANG,APM,TRACING"
  				data-name="PinPoint Golang"
  				data-summary="Tracing Golang applications with PinPoint"
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
                            <div title="Tracing Golang applications with PinPoint" class="fth-integration-desc">Tracing Golang applications with PinPoint</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,JAVA,APM,TRACING"
  				data-name="PinPoint Java"
  				data-summary="Tracing Java applications with PinPoint"
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
                            <div title="Tracing Java applications with PinPoint" class="fth-integration-desc">Tracing Java applications with PinPoint</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,APM,TRACING"
  				data-name="Pinpoint"
  				data-summary="Receive Pinpoint Tracing data"
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
                            <div title="Receive Pinpoint Tracing data" class="fth-integration-desc">Receive Pinpoint Tracing data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=""
  				data-name="Pipeline Offload"
  				data-summary="Receive pending data offloaded from the datakit pipeline"
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
                            <div title="Receive pending data offloaded from the datakit pipeline" class="fth-integration-desc">Receive pending data offloaded from the datakit pipeline</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="PostgreSQL"
  				data-summary="Collect PostgreSQL metrics"
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
                            <div title="Collect PostgreSQL metrics" class="fth-integration-desc">Collect PostgreSQL metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Profling C++ applications"
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
                            <div title="Profling C++ applications" class="fth-integration-desc">Profling C++ applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=".NET,PROFILE"
  				data-name="Profiling .Net"
  				data-summary=".Net Profiling Integration"
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
                            <div title=".Net Profiling Integration" class="fth-integration-desc">.Net Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Profiling C++"
  				data-summary="Profling Golang applications"
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
                            <div title="Profling Golang applications" class="fth-integration-desc">Profling Golang applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Profling Java applications"
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
                            <div title="Profling Java applications" class="fth-integration-desc">Profling Java applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Profling NodeJS applications"
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
                            <div title="Profling NodeJS applications" class="fth-integration-desc">Profling NodeJS applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="PHP Profiling Integration"
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
                            <div title="PHP Profiling Integration" class="fth-integration-desc">PHP Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Profling Python applications"
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
                            <div title="Profling Python applications" class="fth-integration-desc">Profling Python applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect application runtime performance data"
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
                            <div title="Collect application runtime performance data" class="fth-integration-desc">Collect application runtime performance data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PROMETHEUS,THIRD PARTY"
  				data-name="Prometheus Exporter"
  				data-summary="Collect metrics exposed by Prometheus Exporter"
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
                            <div title="Collect metrics exposed by Prometheus Exporter" class="fth-integration-desc">Collect metrics exposed by Prometheus Exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY,PROMETHEUS"
  				data-name="Prometheus Remote Write"
  				data-summary="Receive metrics via Prometheus Remote Write"
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
                            <div title="Receive metrics via Prometheus Remote Write" class="fth-integration-desc">Receive metrics via Prometheus Remote Write</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY"
  				data-name="Promtail"
  				data-summary="Collect log data reported by Promtail"
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
                            <div title="Collect log data reported by Promtail" class="fth-integration-desc">Collect log data reported by Promtail</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=""
  				data-name="Proxy"
  				data-summary="Proxy HTTP requests to Datakit"
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
                            <div title="Proxy HTTP requests to Datakit" class="fth-integration-desc">Proxy HTTP requests to Datakit</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY,PROMETHEUS"
  				data-name="Prometheus Push Gateway"
  				data-summary="Enable Pushgateway API to receive Prometheus metric data"
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
                            <div title="Enable Pushgateway API to receive Prometheus metric data" class="fth-integration-desc">Enable Pushgateway API to receive Prometheus metric data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Grafana Pyroscope Application Performance Profiler"
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
                            <div title="Grafana Pyroscope Application Performance Profiler" class="fth-integration-desc">Grafana Pyroscope Application Performance Profiler</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect data via Python extension"
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
                            <div title="Collect data via Python extension" class="fth-integration-desc">Collect data via Python extension</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Grafana Dashboard template import tool for <<< custom_key.brand_name >>>"
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
                            <div title="Grafana Dashboard template import tool for <<< custom_key.brand_name >>>" class="fth-integration-desc">Grafana Dashboard template import tool for <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="MESSAGE QUEUES,MIDDLEWARE"
  				data-name="RabbitMQ"
  				data-summary="Collect RabbitMQ metrics"
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
                            <div title="Collect RabbitMQ metrics" class="fth-integration-desc">Collect RabbitMQ metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Ranger Admin Metrics information"
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
                            <div title="Collect Ranger Admin Metrics information" class="fth-integration-desc">Collect Ranger Admin Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Ranger Tagsync Metrics information"
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
                            <div title="Collect Ranger Tagsync Metrics information" class="fth-integration-desc">Collect Ranger Tagsync Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Ranger Usersync Metrics information"
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
                            <div title="Collect Ranger Usersync Metrics information" class="fth-integration-desc">Collect Ranger Usersync Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Redis Sentinel cluster Metrics and log information"
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
                            <div title="Collect Redis Sentinel cluster Metrics and log information" class="fth-integration-desc">Collect Redis Sentinel cluster Metrics and log information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="CACHING,MIDDLEWARE"
  				data-name="Redis"
  				data-summary="Collect Redis metrics and logs"
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
                            <div title="Collect Redis metrics and logs" class="fth-integration-desc">Collect Redis metrics and logs</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Resin performance Metrics, including start time, heap memory, non-heap memory, classes, threads, etc."
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
                            <div title="Display of Resin performance Metrics, including start time, heap memory, non-heap memory, classes, threads, etc." class="fth-integration-desc">Display of Resin performance Metrics, including start time, heap memory, non-heap memory, classes, threads, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect RocketMQ related Metrics information"
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
                            <div title="Collect RocketMQ related Metrics information" class="fth-integration-desc">Collect RocketMQ related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect user behavior data"
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
                            <div title="Collect user behavior data" class="fth-integration-desc">Collect user behavior data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Seata related Metrics information"
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
                            <div title="Collect Seata related Metrics information" class="fth-integration-desc">Collect Seata related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="SECURITY"
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
  				data-tags="HOST"
  				data-name="Hardware Sensors"
  				data-summary="Collect hardware temperature indicators through Sensors command"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/sensors/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Hardware Sensors" class="fth-integration-name">Hardware Sensors</div>
                            <div title="Collect hardware temperature indicators through Sensors command" class="fth-integration-desc">Collect hardware temperature indicators through Sensors command</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING,SKYWALKING"
  				data-name="SkyWalking"
  				data-summary="SkyWalking Tracing Data Ingestion"
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
                            <div title="SkyWalking Tracing Data Ingestion" class="fth-integration-desc">SkyWalking Tracing Data Ingestion</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Disk S.M.A.R.T"
  				data-summary="Collect disk metrics through smartctl"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/smartctl/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Disk S.M.A.R.T" class="fth-integration-name">Disk S.M.A.R.T</div>
                            <div title="Collect disk metrics through smartctl" class="fth-integration-desc">Collect disk metrics through smartctl</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics and object data from SNMP devices"
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
                            <div title="Collect metrics and object data from SNMP devices" class="fth-integration-desc">Collect metrics and object data from SNMP devices</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="NETWORK"
  				data-name="Socket"
  				data-summary="Collect metrics of TCP/UDP ports"
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
                            <div title="Collect metrics of TCP/UDP ports" class="fth-integration-desc">Collect metrics of TCP/UDP ports</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="Solr"
  				data-summary="Collect Solr metrics"
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
                            <div title="Collect Solr metrics" class="fth-integration-desc">Collect Solr metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="SQLServer"
  				data-summary="Collect SQLServer Metrics"
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
                            <div title="Collect SQLServer Metrics" class="fth-integration-desc">Collect SQLServer Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="SSH"
  				data-summary="Collect SSH metrics"
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
                            <div title="Collect SSH metrics" class="fth-integration-desc">Collect SSH metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY"
  				data-name="StatsD"
  				data-summary="Collect metrics reported by StatsD"
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
                            <div title="Collect metrics reported by StatsD" class="fth-integration-desc">Collect metrics reported by StatsD</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="Swap"
  				data-summary="Collect metrics of host swap"
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
                            <div title="Collect metrics of host swap" class="fth-integration-desc">Collect metrics of host swap</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="HOST"
  				data-name="System"
  				data-summary="Collecting metrics data related to the host system"
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
                            <div title="Collecting metrics data related to the host system" class="fth-integration-desc">Collecting metrics data related to the host system</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DATA STORES"
  				data-name="TDengine"
  				data-summary="Collect TDengine metrics"
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
                            <div title="Collect TDengine metrics" class="fth-integration-desc">Collect TDengine metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY"
  				data-name="Telegraf"
  				data-summary="Accept Telegraf collected data"
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
                            <div title="Accept Telegraf collected data" class="fth-integration-desc">Accept Telegraf collected data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud CDB"
  				data-summary="Use the script market "official script market" series script package to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud CDB" class="fth-integration-name">Tencent Cloud CDB</div>
                            <div title="Use the script market "official script market" series script package to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script market "official script market" series script package to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud CKafka"
  				data-summary="The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability guarantees of CKafka when handling large-scale message passing and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_ckafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud CKafka" class="fth-integration-name">Tencent Cloud CKafka</div>
                            <div title="The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability guarantees of CKafka when handling large-scale message passing and real-time data streams." class="fth-integration-desc">The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability guarantees of CKafka when handling large-scale message passing and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud CLB Private"
  				data-summary="Use the script package series in the Script Market called "<<< custom_key.brand_name >>> Cloud Sync" to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud CLB Private" class="fth-integration-name">Tencent Cloud CLB Private</div>
                            <div title="Use the script package series in the Script Market called "<<< custom_key.brand_name >>> Cloud Sync" to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>." class="fth-integration-desc">Use the script package series in the Script Market called "<<< custom_key.brand_name >>> Cloud Sync" to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud CLB Public"
  				data-summary="Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud CLB Public" class="fth-integration-name">Tencent Cloud CLB Public</div>
                            <div title="Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud COS"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud COS" class="fth-integration-name">Tencent Cloud COS</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud CVM"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud CVM" class="fth-integration-name">Tencent Cloud CVM</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud KeeWiDB"
  				data-summary="Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_keewidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud KeeWiDB" class="fth-integration-name">Tencent Cloud KeeWiDB</div>
                            <div title="Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc." class="fth-integration-desc">Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud MariaDB"
  				data-summary="Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize the data of cloud monitoring and cloud assets to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud MariaDB" class="fth-integration-name">Tencent Cloud MariaDB</div>
                            <div title="Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize the data of cloud monitoring and cloud assets to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize the data of cloud monitoring and cloud assets to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud Memcached"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud Memcached" class="fth-integration-name">Tencent Cloud Memcached</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud MongoDB"
  				data-summary="Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud MongoDB" class="fth-integration-name">Tencent Cloud MongoDB</div>
                            <div title="Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>." class="fth-integration-desc">Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud PostgreSQL"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud PostgreSQL" class="fth-integration-name">Tencent Cloud PostgreSQL</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud Redis"
  				data-summary="Tencent Cloud Redis Metrics Display, including connections, requests, latency, slow queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_redis_mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud Redis" class="fth-integration-name">Tencent Cloud Redis</div>
                            <div title="Tencent Cloud Redis Metrics Display, including connections, requests, latency, slow queries, etc." class="fth-integration-desc">Tencent Cloud Redis Metrics Display, including connections, requests, latency, slow queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud SQLServer"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script package in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud SQLServer" class="fth-integration-name">Tencent Cloud SQLServer</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script package in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script package in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tencent Cloud"
  				data-name="Tencent Cloud TDSQL_C_MySQL"
  				data-summary="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_tdsql_c_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Tencent Cloud TDSQL_C_MySQL" class="fth-integration-name">Tencent Cloud TDSQL_C_MySQL</div>
                            <div title="Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>" class="fth-integration-desc">Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>></div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect related component Metrics information of TiDB cluster, TiDB, Etcd, Region, etc."
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
                            <div title="Collect related component Metrics information of TiDB cluster, TiDB, Etcd, Region, etc." class="fth-integration-desc">Collect related component Metrics information of TiDB cluster, TiDB, Etcd, Region, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="WEB SERVER,MIDDLEWARE"
  				data-name="Tomcat"
  				data-summary="Collect Tomcat metrics"
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
                            <div title="Collect Tomcat metrics" class="fth-integration-desc">Collect Tomcat metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="APM,TRACING"
  				data-name="Tracing Propagator"
  				data-summary="Propagation between multiple tracing agents"
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
                            <div title="Propagation between multiple tracing agents" class="fth-integration-desc">Propagation between multiple tracing agents</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Trino Metrics information"
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
                            <div title="Collect Trino Metrics information" class="fth-integration-desc">Collect Trino Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="VMware displays cluster status, host status, VM status, and other Metrics."
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
                            <div title="VMware displays cluster status, host status, VM status, and other Metrics." class="fth-integration-desc">VMware displays cluster status, host status, VM status, and other Metrics.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine ALB"
  				data-summary="Collect Volcengine ALB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_alb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine ALB" class="fth-integration-name">Volcengine ALB</div>
                            <div title="Collect Volcengine ALB Metrics data" class="fth-integration-desc">Collect Volcengine ALB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine CLB"
  				data-summary="Collect Volcengine CLB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine CLB" class="fth-integration-name">Volcengine CLB</div>
                            <div title="Collect Volcengine CLB Metrics data" class="fth-integration-desc">Collect Volcengine CLB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine ECS"
  				data-summary="The displayed Metrics for Volcengine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computation, memory, network, and storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine ECS" class="fth-integration-name">Volcengine ECS</div>
                            <div title="The displayed Metrics for Volcengine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computation, memory, network, and storage." class="fth-integration-desc">The displayed Metrics for Volcengine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computation, memory, network, and storage.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine EIP"
  				data-summary="Collect Volcengine EIP Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine EIP" class="fth-integration-name">Volcengine EIP</div>
                            <div title="Collect Volcengine EIP Metrics data" class="fth-integration-desc">Collect Volcengine EIP Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine MongoDB Replica Set"
  				data-summary="Display of Volcengine MongoDB Replica Set Metrics, including CPU usage, memory usage, number of connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine MongoDB Replica Set" class="fth-integration-name">Volcengine MongoDB Replica Set</div>
                            <div title="Display of Volcengine MongoDB Replica Set Metrics, including CPU usage, memory usage, number of connections, latency, OPS, etc." class="fth-integration-desc">Display of Volcengine MongoDB Replica Set Metrics, including CPU usage, memory usage, number of connections, latency, OPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine MongoDB Sharded Cluster"
  				data-summary="Display of Volcengine MongoDB sharded cluster metrics, including CPU usage, memory usage, connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine MongoDB Sharded Cluster" class="fth-integration-name">Volcengine MongoDB Sharded Cluster</div>
                            <div title="Display of Volcengine MongoDB sharded cluster metrics, including CPU usage, memory usage, connections, latency, OPS, etc." class="fth-integration-desc">Display of Volcengine MongoDB sharded cluster metrics, including CPU usage, memory usage, connections, latency, OPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine MySQL"
  				data-summary="Volcengine MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine MySQL" class="fth-integration-name">Volcengine MySQL</div>
                            <div title="Volcengine MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">Volcengine MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine NAS File Storage"
  				data-summary="Collecting Volcengine NAS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_nas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine NAS File Storage" class="fth-integration-name">Volcengine NAS File Storage</div>
                            <div title="Collecting Volcengine NAS Metrics data" class="fth-integration-desc">Collecting Volcengine NAS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine Redis"
  				data-summary="Volcengine Redis Metrics Collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine Redis" class="fth-integration-name">Volcengine Redis</div>
                            <div title="Volcengine Redis Metrics Collection" class="fth-integration-desc">Volcengine Redis Metrics Collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine TOS Object Storage"
  				data-summary="Collect Volcengine TOS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_tos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine TOS Object Storage" class="fth-integration-name">Volcengine TOS Object Storage</div>
                            <div title="Collect Volcengine TOS Metrics data" class="fth-integration-desc">Collect Volcengine TOS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volcengine"
  				data-name="Volcengine VKE"
  				data-summary="Volcengine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_vke/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Volcengine VKE" class="fth-integration-name">Volcengine VKE</div>
                            <div title="Volcengine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc." class="fth-integration-desc">Volcengine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect vSphere metrics"
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
                            <div title="Collect vSphere metrics" class="fth-integration-desc">Collect vSphere metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Windows Event"
  				data-summary="Collect event logs in Windows"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/winevent/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Windows Event" class="fth-integration-name">Windows Event</div>
                            <div title="Collect event logs in Windows" class="fth-integration-desc">Collect event logs in Windows</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collects quota information from the xfs file system"
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
                            <div title="Collects quota information from the xfs file system" class="fth-integration-desc">Collects quota information from the xfs file system</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="THIRD PARTY"
  				data-name="Zabbix Export"
  				data-summary="Zabbix real-time data exporter"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zabbix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div title="Zabbix Export" class="fth-integration-name">Zabbix Export</div>
                            <div title="Zabbix real-time data exporter" class="fth-integration-desc">Zabbix real-time data exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Zadigx displays metrics including Overview, Automated Build, Automated Deployment, and Automated Testing."
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
                            <div title="Zadigx displays metrics including Overview, Automated Build, Automated Deployment, and Automated Testing." class="fth-integration-desc">Zadigx displays metrics including Overview, Automated Build, Automated Deployment, and Automated Testing.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="ZIPKIN,APM,TRACING"
  				data-name="Zipkin"
  				data-summary="Zipkin Tracing Data Ingestion"
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
                            <div title="Zipkin Tracing Data Ingestion" class="fth-integration-desc">Zipkin Tracing Data Ingestion</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect ZooKeeper related Metrics information"
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
                            <div title="Collect ZooKeeper related Metrics information" class="fth-integration-desc">Collect ZooKeeper related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
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
            const limitTags = ['Alibaba Cloud', 'Tencent Cloud', 'Huawei Cloud', 'GCP', 'AWS', 'AZURE', 'MIDDLEWARE', 'HOST', 'IPMI', 'KUBERNETES', 'CONTAINERS', 'NETWORK', 'EBPF', 'BPF', 'SNMP', 'PROMETHEUS', 'ZABBIX', 'TELEGRAF', 'CACHING', 'MESSAGE QUEUES', 'DATABASE', 'LANGUAGE', 'APM', 'PROFILE', 'LOG', 'TESTING', 'WEB', 'MOBILE', 'CI/CD', 'JENKINS', 'GITLAB', 'SESSION REPLAY'];
            const limitTagsToLower=limitTags.map(v=>v.toLowerCase())
            const tagAll = { label: 'All', value: '' };
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
