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
  			text-overflow: ellipsis;
  			overflow: hidden;
  			white-space: nowrap;
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
  				data-href="../active_directory"
  				data-tags=""
  				data-name="Active Directory"
  				data-summary="Collect metrics related to Active Directory"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/active_directory/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Active Directory</div>
                            <div title="Collect metrics related to Active Directory" class="fth-integration-desc">Collect metrics related to Active Directory</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to Aerospike"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aerospike/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Aerospike</div>
                            <div title="Collect metrics related to Aerospike" class="fth-integration-desc">Collect metrics related to Aerospike</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud AnalyticDB PostgreSQL Metrics display, including CPU, memory, disk, coordinator node, instance queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_analyticdb_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud AnalyticDB PostgreSQL</div>
                            <div title="Alibaba Cloud AnalyticDB PostgreSQL Metrics display, including CPU, memory, disk, coordinator node, instance queries, etc." class="fth-integration-desc">Alibaba Cloud AnalyticDB PostgreSQL Metrics display, including CPU, memory, disk, coordinator node, instance queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Performance metrics display for Alibaba Cloud CDN, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_cdn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud CDN</div>
                            <div title="Performance metrics display for Alibaba Cloud CDN, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc." class="fth-integration-desc">Performance metrics display for Alibaba Cloud CDN, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Alibaba Cloud ClickHouse Community Compatible Edition"
  				data-summary="Display of Alibaba Cloud ClickHouse metrics, including service status, log traffic, operation counts, overall QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_clickhouse_community/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud ClickHouse Community Compatible Edition</div>
                            <div title="Display of Alibaba Cloud ClickHouse metrics, including service status, log traffic, operation counts, overall QPS, etc." class="fth-integration-desc">Display of Alibaba Cloud ClickHouse metrics, including service status, log traffic, operation counts, overall QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud,Host"
  				data-name="Alibaba Cloud ECS"
  				data-summary="The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud ECS</div>
                            <div title="The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage." class="fth-integration-desc">The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Alibaba Cloud EDAS Metrics and tracing data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_edas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud EDAS</div>
                            <div title="Collect Alibaba Cloud EDAS Metrics and tracing data" class="fth-integration-desc">Collect Alibaba Cloud EDAS Metrics and tracing data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Alibaba Cloud EIP metrics, including network bandwidth, network packets, rate-limited packet loss rate, bandwidth utilization, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud EIP</div>
                            <div title="Display of Alibaba Cloud EIP metrics, including network bandwidth, network packets, rate-limited packet loss rate, bandwidth utilization, etc." class="fth-integration-desc">Display of Alibaba Cloud EIP metrics, including network bandwidth, network packets, rate-limited packet loss rate, bandwidth utilization, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage rates, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud ElasticSearch</div>
                            <div title="Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage rates, etc." class="fth-integration-desc">Alibaba Cloud ElasticSearch Metrics display, including cluster status, index QPS, node CPU/memory/disk usage rates, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, and message consumption frequency. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud KafKa</div>
                            <div title="Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, and message consumption frequency. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams." class="fth-integration-desc">Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, and message consumption frequency. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the cloud synchronization script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_lindorm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud Lindorm</div>
                            <div title="Use the cloud synchronization script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance." class="fth-integration-desc">Use the cloud synchronization script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB sharded cluster metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB single-node instance metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, statements executed per second, number of requests, connections, network traffic, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud MongoDB</div>
                            <div title="Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB sharded cluster metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB single-node instance metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, statements executed per second, number of requests, connections, network traffic, QPS, etc." class="fth-integration-desc">Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB sharded cluster metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, statements executed per second, number of requests, connections, network traffic, replication delay, QPS, etc.
Alibaba Cloud MongoDB single-node instance metrics display, including CPU usage, memory usage, disk usage, data disk space occupied, statements executed per second, number of requests, connections, network traffic, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud NAT metrics display, including concurrent connections, new connections, VPC traffic, VPC packets, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_nat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud NAT</div>
                            <div title="Alibaba Cloud NAT metrics display, including concurrent connections, new connections, VPC traffic, VPC packets, etc." class="fth-integration-desc">Alibaba Cloud NAT metrics display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The display metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These metrics reflect the performance and credibility of the new BGP high defense service in handling large-scale DDoS attacks."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_newbgp_ddos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud DDoS New BGP High Defense</div>
                            <div title="The display metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These metrics reflect the performance and credibility of the new BGP high defense service in handling large-scale DDoS attacks." class="fth-integration-desc">The display metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These metrics reflect the performance and credibility of the new BGP high defense service in handling large-scale DDoS attacks.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud OSS metrics display, including request count, availability, network traffic, request ratio, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_oss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud OSS</div>
                            <div title="Alibaba Cloud OSS metrics display, including request count, availability, network traffic, request ratio, etc." class="fth-integration-desc">Alibaba Cloud OSS metrics display, including request count, availability, network traffic, request ratio, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud PolarDB Distributed 1.0 displays Metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud PolarDB Distributed 1.0</div>
                            <div title="Alibaba Cloud PolarDB Distributed 1.0 displays Metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS." class="fth-integration-desc">Alibaba Cloud PolarDB Distributed 1.0 displays Metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud PolarDB Distributed 2.0 displays metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage, disk usage rate, memory utilization, network bandwidth, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud PolarDB Distributed 2.0</div>
                            <div title="Alibaba Cloud PolarDB Distributed 2.0 displays metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage, disk usage rate, memory utilization, network bandwidth, etc." class="fth-integration-desc">Alibaba Cloud PolarDB Distributed 2.0 displays metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage, disk usage rate, memory utilization, network bandwidth, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Alibaba Cloud PolarDB MySQL metrics, including CPU usage, memory hit rate, network traffic, connections, QPS, TPS, read-only node delay, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud PolarDB MySQL</div>
                            <div title="Display of Alibaba Cloud PolarDB MySQL metrics, including CPU usage, memory hit rate, network traffic, connections, QPS, TPS, read-only node delay, etc." class="fth-integration-desc">Display of Alibaba Cloud PolarDB MySQL metrics, including CPU usage, memory hit rate, network traffic, connections, QPS, TPS, read-only node delay, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud PolarDB Oracle Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud PolarDB Oracle</div>
                            <div title="Alibaba Cloud PolarDB Oracle Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc." class="fth-integration-desc">Alibaba Cloud PolarDB Oracle Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud PolarDB PostgreSQL Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud PolarDB PostgreSQL</div>
                            <div title="Alibaba Cloud PolarDB PostgreSQL Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc." class="fth-integration-desc">Alibaba Cloud PolarDB PostgreSQL Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud RDS MariaDB</div>
                            <div title="The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS." class="fth-integration-desc">The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Alibaba Cloud RDS MySQL metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud RDS MySQL</div>
                            <div title="Display of Alibaba Cloud RDS MySQL metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">Display of Alibaba Cloud RDS MySQL metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud RDS PostgreSQL Metrics display, including CPU usage, memory usage, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud RDS PostgreSQL</div>
                            <div title="Alibaba Cloud RDS PostgreSQL Metrics display, including CPU usage, memory usage, etc." class="fth-integration-desc">Alibaba Cloud RDS PostgreSQL Metrics display, including CPU usage, memory usage, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud RDS SQLServer</div>
                            <div title="Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, and accesses per second."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud Redis Standard Edition</div>
                            <div title="Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, and accesses per second." class="fth-integration-desc">Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, and accesses per second.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, and requests per second."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud Redis Cluster Edition</div>
                            <div title="Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, and requests per second." class="fth-integration-desc">Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, and requests per second.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud RocketMQ4</div>
                            <div title="The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability." class="fth-integration-desc">The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Alibaba Cloud RocketMQ5</div>
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
  				data-summary="Collect metrics, logs, and tracing information from Alibaba Cloud SAE (Serverless App Engine)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sae/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud SAE</div>
                            <div title="Collect metrics, logs, and tracing information from Alibaba Cloud SAE (Serverless App Engine)" class="fth-integration-desc">Collect metrics, logs, and tracing information from Alibaba Cloud SAE (Serverless App Engine)</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud Site Monitoring primarily obtains site dial test information."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_site/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud Site Monitoring</div>
                            <div title="Alibaba Cloud Site Monitoring primarily obtains site dial test information." class="fth-integration-desc">Alibaba Cloud Site Monitoring primarily obtains site dial test information.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Alibaba Cloud SLB</div>
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
  				data-summary="Alibaba Cloud SLS metrics display, including service status, log traffic, operation counts, overall QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_sls/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud SLS</div>
                            <div title="Alibaba Cloud SLS metrics display, including service status, log traffic, operation counts, overall QPS, etc." class="fth-integration-desc">Alibaba Cloud SLS metrics display, including service status, log traffic, operation counts, overall QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Alibaba Cloud Tair Community Edition metrics display, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_tair/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Alibaba Cloud Tair Community Edition</div>
                            <div title="Alibaba Cloud Tair Community Edition metrics display, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc." class="fth-integration-desc">Alibaba Cloud Tair Community Edition metrics display, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware,WEB SERVER"
  				data-name="Apache"
  				data-summary="The Apache collector can gather request counts, connection counts, and other data from Apache services"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apache/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Apache</div>
                            <div title="The Apache collector can gather request counts, connection counts, and other data from Apache services" class="fth-integration-desc">The Apache collector can gather request counts, connection counts, and other data from Apache services</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect APISIX related Metrics, logs, and trace information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apisix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">APISIX</div>
                            <div title="Collect APISIX related Metrics, logs, and trace information" class="fth-integration-desc">Collect APISIX related Metrics, logs, and trace information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Apollo-related Metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apollo/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Apollo</div>
                            <div title="Collect Apollo-related Metrics information" class="fth-integration-desc">Collect Apollo-related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Argo CD service status, application status, logs, and tracing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/argocd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">ArgoCD</div>
                            <div title="Collect Argo CD service status, application status, logs, and tracing information" class="fth-integration-desc">Collect Argo CD service status, application status, logs, and tracing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to AutoMQ"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/automq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AutoMQ</div>
                            <div title="Collect metrics related to AutoMQ" class="fth-integration-desc">Collect metrics related to AutoMQ</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics of AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway in handling API requests and traffic management."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_api_gateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS API Gateway</div>
                            <div title="The displayed metrics of AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway in handling API requests and traffic management." class="fth-integration-desc">The displayed metrics of AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway in handling API requests and traffic management.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS Auto Scaling, including instance counts, capacity units, warm pools, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_auto_scaling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Auto Scaling</div>
                            <div title="AWS Auto Scaling, including instance counts, capacity units, warm pools, etc." class="fth-integration-desc">AWS Auto Scaling, including instance counts, capacity units, warm pools, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collecting AWS cloud billing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Cloud Billing</div>
                            <div title="Collecting AWS cloud billing information" class="fth-integration-desc">Collecting AWS cloud billing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">AWS CloudFront</div>
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
  				data-summary="The metrics displayed for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These metrics reflect the performance and reliability of DMS during database migration and replication."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dms/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS DMS</div>
                            <div title="The metrics displayed for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These metrics reflect the performance and reliability of DMS during database migration and replication." class="fth-integration-desc">The metrics displayed for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These metrics reflect the performance and reliability of DMS during database migration and replication.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The metrics displayed for AWS DocumentDB include read and write throughput, query latency, and scalability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_documentdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS DocumentDB</div>
                            <div title="The metrics displayed for AWS DocumentDB include read and write throughput, query latency, and scalability." class="fth-integration-desc">The metrics displayed for AWS DocumentDB include read and write throughput, query latency, and scalability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The metrics displayed for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS DynamoDB</div>
                            <div title="The metrics displayed for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access." class="fth-integration-desc">The metrics displayed for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, bytes received or transmitted on all network interfaces, number of packets, etc. These metrics reflect the operational status of DynamoDB DAX."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb_DAX/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS DynamoDB DAX</div>
                            <div title="The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, bytes received or transmitted on all network interfaces, number of packets, etc. These metrics reflect the operational status of DynamoDB DAX." class="fth-integration-desc">The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, bytes received or transmitted on all network interfaces, number of packets, etc. These metrics reflect the operational status of DynamoDB DAX.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS EC2</div>
                            <div title="Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary=" Amazon EC2 Spot, including request capacity pools, target capacity pools, and terminated capacity."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2_spot/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Amazon EC2 Spot</div>
                            <div title=" Amazon EC2 Spot, including request capacity pools, target capacity pools, and terminated capacity." class="fth-integration-desc"> Amazon EC2 Spot, including request capacity pools, target capacity pools, and terminated capacity.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Amazon ECS features integrated with the Amazon Web Services Fargate serverless computing engine, monitored using Guance for service runtime."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS ECS</div>
                            <div title="Amazon ECS features integrated with the Amazon Web Services Fargate serverless computing engine, monitored using Guance for service runtime." class="fth-integration-desc">Amazon ECS features integrated with the Amazon Web Services Fargate serverless computing engine, monitored using Guance for service runtime.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS ElastiCache Redis</div>
                            <div title="Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the Script Market of Guance to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_serverless/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS ElastiCache Serverless</div>
                            <div title="Use the script packages in the Script Market of Guance to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the Script Market of Guance to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS ELB</div>
                            <div title="Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the cloud synchronization script package from the Script Market to sync cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_emr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS EMR</div>
                            <div title="Use the cloud synchronization script package from the Script Market to sync cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the cloud synchronization script package from the Script Market to sync cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics of AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge in processing large-scale event streams and real-time data delivery."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_eventbridge/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS EventBridge</div>
                            <div title="The displayed Metrics of AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge in processing large-scale event streams and real-time data delivery." class="fth-integration-desc">The displayed Metrics of AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge in processing large-scale event streams and real-time data delivery.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">AWS Firehose HTTP Endpoint</div>
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
  				data-summary="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Kinesis</div>
                            <div title="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis_analytics/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS KinesisAnalytics</div>
                            <div title="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_lambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Lambda</div>
                            <div title="The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions." class="fth-integration-desc">The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">AWS MediaConvert</div>
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
  				data-summary="Use the script packages in the script market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_memorydb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS MemoryDB</div>
                            <div title="Use the script packages in the script market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Amazon MQ supports industry-standard APIs and protocols, manages the management and maintenance of message brokers, and automatically provides infrastructure for high availability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_mq_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Amazon MQ for RabbitMQ</div>
                            <div title="Amazon MQ supports industry-standard APIs and protocols, manages the management and maintenance of message brokers, and automatically provides infrastructure for high availability." class="fth-integration-desc">Amazon MQ supports industry-standard APIs and protocols, manages the management and maintenance of message brokers, and automatically provides infrastructure for high availability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use script packages from the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_msk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS MSK</div>
                            <div title="Use script packages from the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use script packages from the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_neptune_cluster/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Neptune Cluster</div>
                            <div title="The displayed Metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function." class="fth-integration-desc">The displayed Metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS OpenSearch, including connection counts, request numbers, latency, and slow queries."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_opensearch/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS OpenSearch</div>
                            <div title="AWS OpenSearch, including connection counts, request numbers, latency, and slow queries." class="fth-integration-desc">AWS OpenSearch, including connection counts, request numbers, latency, and slow queries.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use script packages from the script market in the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS RDS MySQL</div>
                            <div title="Use script packages from the script market in the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use script packages from the script market in the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">AWS Redshift</div>
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
  				data-summary="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_s3/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS S3</div>
                            <div title="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics of AWS Simple Queue Service include the approximate existence time of the oldest undeleleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_sqs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Simple Queue Service</div>
                            <div title="The displayed metrics of AWS Simple Queue Service include the approximate existence time of the oldest undeleleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc." class="fth-integration-desc">The displayed metrics of AWS Simple Queue Service include the approximate existence time of the oldest undeleleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The metrics displayed for AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_timestream/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Timestream</div>
                            <div title="The metrics displayed for AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage." class="fth-integration-desc">The metrics displayed for AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect data using AWS Lambda Extension"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/awslambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">AWS Lambda Extension</div>
                            <div title="Collect data using AWS Lambda Extension" class="fth-integration-desc">Collect data using AWS Lambda Extension</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Azure MySQL metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/azure_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Azure MySQL</div>
                            <div title="Collect Azure MySQL metrics data" class="fth-integration-desc">Collect Azure MySQL metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="AZURE,Network"
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
                            <div class="fth-integration-name">Azure Public IP Address</div>
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
                            <div class="fth-integration-name">Azure SQL Servers</div>
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
                            <div class="fth-integration-name">Azure Virtual Machines</div>
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
  				data-tags="Logs"
  				data-name="Filebeat"
  				data-summary="Receive log data collected by Filebeat"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/beats/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Filebeat</div>
                            <div title="Receive log data collected by Filebeat" class="fth-integration-desc">Receive log data collected by Filebeat</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="Cassandra"
  				data-summary="Collect Metrics data from Cassandra"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Cassandra</div>
                            <div title="Collect Metrics data from Cassandra" class="fth-integration-desc">Collect Metrics data from Cassandra</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Trace Analysis"
  				data-name="Dianping CAT"
  				data-summary="A performance, capacity, and business metrics monitoring system by Meituan Dianping"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Dianping CAT</div>
                            <div title="A performance, capacity, and business metrics monitoring system by Meituan Dianping" class="fth-integration-desc">A performance, capacity, and business metrics monitoring system by Meituan Dianping</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data related to Chrony server"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/chrony/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Chrony</div>
                            <div title="Collect metrics data related to Chrony server" class="fth-integration-desc">Collect metrics data related to Chrony server</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="database"
  				data-name="ClickHouse"
  				data-summary="Collect metrics data from ClickHouse"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/clickhouse/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">ClickHouse</div>
                            <div title="Collect metrics data from ClickHouse" class="fth-integration-desc">Collect metrics data from ClickHouse</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Cloud Billing Cost Inquiry"
  				data-summary="Cloud billing cost inquiry, which can query public cloud billing information from AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/asset//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Cloud Billing Cost Inquiry</div>
                            <div title="Cloud billing cost inquiry, which can query public cloud billing information from AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc." class="fth-integration-desc">Cloud billing cost inquiry, which can query public cloud billing information from AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Receive Cloudprober data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cloudprober/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Cloudprober</div>
                            <div title="Receive Cloudprober data" class="fth-integration-desc">Receive Cloudprober data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="database"
  				data-name="CockroachDB"
  				data-summary="Collect metrics data from CockroachDB"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cockroachdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">CockroachDB</div>
                            <div title="Collect metrics data from CockroachDB" class="fth-integration-desc">Collect metrics data from CockroachDB</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware"
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
                            <div class="fth-integration-name">Confluent Cloud</div>
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
  				data-tags="Middleware"
  				data-name="Consul"
  				data-summary="Collect metrics data from Consul"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/consul/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Consul</div>
                            <div title="Collect metrics data from Consul" class="fth-integration-desc">Collect metrics data from Consul</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Logs,Container,KUBERNETES"
  				data-name="Kubernetes Logs"
  				data-summary="Collecting Container and Kubernetes Log Data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kubernetes Logs</div>
                            <div title="Collecting Container and Kubernetes Log Data" class="fth-integration-desc">Collecting Container and Kubernetes Log Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="KUBERNETES,Container"
  				data-name="Kubernetes"
  				data-summary="Collect metrics, objects, and log data from Container and Kubernetes and report to Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kubernetes</div>
                            <div title="Collect metrics, objects, and log data from Container and Kubernetes and report to Guance." class="fth-integration-desc">Collect metrics, objects, and log data from Container and Kubernetes and report to Guance.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware"
  				data-name="CoreDNS"
  				data-summary="Collect metrics data from CoreDNS"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/coredns/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">CoreDNS</div>
                            <div title="Collect metrics data from CoreDNS" class="fth-integration-desc">Collect metrics data from CoreDNS</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../couchbase-prom"
  				data-tags=""
  				data-name="CouchBase Exporter"
  				data-summary="The collector can gather many metrics from a CouchBase instance, such as memory and disk usage for data, current number of connections, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in CouchBase."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/couchbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">CouchBase Exporter</div>
                            <div title="The collector can gather many metrics from a CouchBase instance, such as memory and disk usage for data, current number of connections, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in CouchBase." class="fth-integration-desc">The collector can gather many metrics from a CouchBase instance, such as memory and disk usage for data, current number of connections, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in CouchBase.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="CouchDB"
  				data-summary="Collect Metrics Data from CouchDB"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/couchdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">CouchDB</div>
                            <div title="Collect Metrics Data from CouchDB" class="fth-integration-desc">Collect Metrics Data from CouchDB</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect CPU Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/cpu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">CPU</div>
                            <div title="Collect CPU Metrics data" class="fth-integration-desc">Collect CPU Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="DB2"
  				data-summary="Collect metrics data from IBM DB2"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/db2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DB2</div>
                            <div title="Collect metrics data from IBM DB2" class="fth-integration-desc">Collect metrics data from IBM DB2</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tracing,JAVA"
  				data-name="Automatic Injection of DDTrace-Java Agent"
  				data-summary="DDTrace Java Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Automatic Injection of DDTrace-Java Agent</div>
                            <div title="DDTrace Java Integration" class="fth-integration-desc">DDTrace Java Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tracing,C/C++"
  				data-name="DDTrace C++"
  				data-summary="DDTrace C++ Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace C++</div>
                            <div title="DDTrace C++ Integration" class="fth-integration-desc">DDTrace C++ Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,Trace Analysis"
  				data-name="DDTrace Extension"
  				data-summary="Guance extends DDTrace support for components"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace Extension</div>
                            <div title="Guance extends DDTrace support for components" class="fth-integration-desc">Guance extends DDTrace support for components</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,GOLANG,Tracing"
  				data-name="DDTrace Golang"
  				data-summary="Integration of DDTrace with Golang"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace Golang</div>
                            <div title="Integration of DDTrace with Golang" class="fth-integration-desc">Integration of DDTrace with Golang</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,JAVA,Trace Collection"
  				data-name="DDTrace Java"
  				data-summary="DDTrace Java Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace Java</div>
                            <div title="DDTrace Java Integration" class="fth-integration-desc">DDTrace Java Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,JAVA,Tracing"
  				data-name="DDTrace JMX"
  				data-summary="DDTrace JMX Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace JMX</div>
                            <div title="DDTrace JMX Integration" class="fth-integration-desc">DDTrace JMX Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,NODEJS,Tracing"
  				data-name="DDTrace NodeJS"
  				data-summary="DDTrace NodeJS Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace NodeJS</div>
                            <div title="DDTrace NodeJS Integration" class="fth-integration-desc">DDTrace NodeJS Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,PHP,Tracing"
  				data-name="DDTrace PHP"
  				data-summary="DDTrace PHP Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace PHP</div>
                            <div title="DDTrace PHP Integration" class="fth-integration-desc">DDTrace PHP Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,PYTHON,Tracing"
  				data-name="DDTrace Python"
  				data-summary="DDTrace Python Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace Python</div>
                            <div title="DDTrace Python Integration" class="fth-integration-desc">DDTrace Python Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,RUBY,Tracing"
  				data-name="DDTrace Ruby"
  				data-summary="DDTrace Ruby Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DDTrace Ruby</div>
                            <div title="DDTrace Ruby Integration" class="fth-integration-desc">DDTrace Ruby Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="DDTRACE,Trace Collection"
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
                            <div class="fth-integration-name">DDTrace</div>
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
  				data-tags="Dial Testing,Network"
  				data-name="Network Dial Testing"
  				data-summary="Obtain network performance through network dial testing"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Network Dial Testing</div>
                            <div title="Obtain network performance through network dial testing" class="fth-integration-desc">Obtain network performance through network dial testing</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Dial Testing,Network"
  				data-name="Custom Dial Testing Tasks"
  				data-summary="Customize dial testing collectors to tailor dial testing tasks"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dialtesting/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Custom Dial Testing Tasks</div>
                            <div title="Customize dial testing collectors to tailor dial testing tasks" class="fth-integration-desc">Customize dial testing collectors to tailor dial testing tasks</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Disk"
  				data-summary="Collect metrics data from disk"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/disk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Disk</div>
                            <div title="Collect metrics data from disk" class="fth-integration-desc">Collect metrics data from disk</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Disk IO"
  				data-summary="Collect Disk IO Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/diskio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Disk IO</div>
                            <div title="Collect Disk IO Metrics data" class="fth-integration-desc">Collect Disk IO Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="DataKit Self-Monitoring Metrics Collection"
  				data-summary="Collecting DataKit runtime metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">DataKit Self-Monitoring Metrics Collection</div>
                            <div title="Collecting DataKit runtime metrics" class="fth-integration-desc">Collecting DataKit runtime metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect runtime Metrics information from Dameng Database"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Dameng Database (DM8)</div>
                            <div title="Collect runtime Metrics information from Dameng Database" class="fth-integration-desc">Collect runtime Metrics information from Dameng Database</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Container"
  				data-name="Docker"
  				data-summary="Collect metrics, objects, and log data from Docker Container"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/docker/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Docker</div>
                            <div title="Collect metrics, objects, and log data from Docker Container" class="fth-integration-desc">Collect metrics, objects, and log data from Docker Container</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="TongHttpServer (THS) by Dongfangtong"
  				data-summary="Collect runtime Metrics information of TongHttpServer (THS) by Dongfangtong"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">TongHttpServer (THS) by Dongfangtong</div>
                            <div title="Collect runtime Metrics information of TongHttpServer (THS) by Dongfangtong" class="fth-integration-desc">Collect runtime Metrics information of TongHttpServer (THS) by Dongfangtong</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="TongWeb"
  				data-summary="Collect TongWeb runtime Metrics and tracing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">TongWeb</div>
                            <div title="Collect TongWeb runtime Metrics and tracing information" class="fth-integration-desc">Collect TongWeb runtime Metrics and tracing information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="Doris"
  				data-summary="Collect metrics data from Doris"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/doris/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Doris</div>
                            <div title="Collect metrics data from Doris" class="fth-integration-desc">Collect metrics data from Doris</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">.NET</div>
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
  				data-href="../ebpf"
  				data-tags="EBPF,NETWORK"
  				data-name="eBPF"
  				data-summary="Collect Linux network data via eBPF"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ebpf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">eBPF</div>
                            <div title="Collect Linux network data via eBPF" class="fth-integration-desc">Collect Linux network data via eBPF</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Trace Linking,EBPF"
  				data-name="eBPF Tracing"
  				data-summary="Associate eBPF-collected link spans to generate traces"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ebpf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">eBPF Tracing</div>
                            <div title="Associate eBPF-collected link spans to generate traces" class="fth-integration-desc">Associate eBPF-collected link spans to generate traces</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="ElasticSearch"
  				data-summary="Collect metrics data from ElasticSearch"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/elasticsearch/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">ElasticSearch</div>
                            <div title="Collect metrics data from ElasticSearch" class="fth-integration-desc">Collect metrics data from ElasticSearch</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to EMQX collection, topics, subscriptions, message, and packet"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/emqx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">EMQX</div>
                            <div title="Collect metrics related to EMQX collection, topics, subscriptions, message, and packet" class="fth-integration-desc">Collect metrics related to EMQX collection, topics, subscriptions, message, and packet</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware"
  				data-name="etcd"
  				data-summary="Collect metrics data from etcd"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/etcd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">etcd</div>
                            <div title="Collect metrics data from etcd" class="fth-integration-desc">Collect metrics data from etcd</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to Exchange"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/exchange/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Exchange</div>
                            <div title="Collect metrics related to Exchange" class="fth-integration-desc">Collect metrics related to Exchange</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Launch external programs for collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/external/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">External</div>
                            <div title="Launch external programs for collection" class="fth-integration-desc">Launch external programs for collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware"
  				data-name="Flink"
  				data-summary="Collect metrics data from Flink"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/flink/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Flink</div>
                            <div title="Collect metrics data from Flink" class="fth-integration-desc">Collect metrics data from Flink</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Fluent Bit</div>
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
  				data-summary="Collect logs from Fluentd"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/fluentd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Fluentd</div>
                            <div title="Collect logs from Fluentd" class="fth-integration-desc">Collect logs from Fluentd</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data from GitLab"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gitlab/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">GitLab</div>
                            <div title="Collect metrics data from GitLab" class="fth-integration-desc">Collect metrics data from GitLab</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics, trace data, and log information from Golang applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/go/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Golang</div>
                            <div title="Collect metrics, trace data, and log information from Golang applications" class="fth-integration-desc">Collect metrics, trace data, and log information from Golang applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="GPU"
  				data-summary="Collect NVIDIA GPU Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gpu_smi/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">GPU</div>
                            <div title="Collect NVIDIA GPU Metrics data" class="fth-integration-desc">Collect NVIDIA GPU Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Grafana integration with Guance data provided as a Datasource plugin"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/grafana_datasource/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Grafana Guance Datasource</div>
                            <div title="Grafana integration with Guance data provided as a Datasource plugin" class="fth-integration-desc">Grafana integration with Guance data provided as a Datasource plugin</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion"
  				data-name="Graphite"
  				data-summary="Collect metrics data exposed by Graphite Exporter"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/graphite/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Graphite</div>
                            <div title="Collect metrics data exposed by Graphite Exporter" class="fth-integration-desc">Collect metrics data exposed by Graphite Exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">GreenPlum</div>
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
                            <div class="fth-integration-name">Hadoop HDFS DataNode</div>
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
  				data-summary="Collect HDFS namenode metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-hdfs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Hadoop HDFS NameNode</div>
                            <div title="Collect HDFS namenode metrics information" class="fth-integration-desc">Collect HDFS namenode metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Yarn NodeManager Metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hadoop-yarn/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Hadoop Yarn NodeManager</div>
                            <div title="Collect Yarn NodeManager Metrics information" class="fth-integration-desc">Collect Yarn NodeManager Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Hadoop Yarn ResourceManager</div>
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
                            <div class="fth-integration-name">Haproxy</div>
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
  				data-summary="Collect HBase Master Metrics Information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">HBase Master</div>
                            <div title="Collect HBase Master Metrics Information" class="fth-integration-desc">Collect HBase Master Metrics Information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">HBase Region</div>
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
  				data-tags="Host"
  				data-name="Host Health Check"
  				data-summary="Periodically check the health status of host processes and network"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/healthcheck/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Host Health Check</div>
                            <div title="Periodically check the health status of host processes and network" class="fth-integration-desc">Periodically check the health status of host processes and network</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Process"
  				data-summary="Collect metrics and object data from processes"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/process/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Process</div>
                            <div title="Collect metrics and object data from processes" class="fth-integration-desc">Collect metrics and object data from processes</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="File Directory"
  				data-summary="Collect metrics data from file directories"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostdir/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">File Directory</div>
                            <div title="Collect metrics data from file directories" class="fth-integration-desc">Collect metrics data from file directories</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Host Object"
  				data-summary="Collect basic host information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/hostobject/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Host Object</div>
                            <div title="Collect basic host information" class="fth-integration-desc">Collect basic host information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The metrics displayed for Huawei Cloud FunctionGraph include invocation counts, error counts, rejected counts, concurrency numbers, reserved instance counts, and runtime (including maximum, minimum, and average runtimes). These metrics reflect the operational status of FunctionGraph functions."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_functiongraph/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud FunctionGraph</div>
                            <div title="The metrics displayed for Huawei Cloud FunctionGraph include invocation counts, error counts, rejected counts, concurrency numbers, reserved instance counts, and runtime (including maximum, minimum, and average runtimes). These metrics reflect the operational status of FunctionGraph functions." class="fth-integration-desc">The metrics displayed for Huawei Cloud FunctionGraph include invocation counts, error counts, rejected counts, concurrency numbers, reserved instance counts, and runtime (including maximum, minimum, and average runtimes). These metrics reflect the operational status of FunctionGraph functions.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The core performance metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_sys_as/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">HUAWEI AS</div>
                            <div title="The core performance metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system." class="fth-integration-desc">The core performance metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_sys_cbr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud CBR</div>
                            <div title="The displayed metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management." class="fth-integration-desc">The displayed metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of DDMS in handling large-scale message delivery and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huaweiyun_SYS_DDMS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud DDM</div>
                            <div title="The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of DDMS in handling large-scale message delivery and real-time data streams." class="fth-integration-desc">The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of DDMS in handling large-scale message delivery and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_apic/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud API</div>
                            <div title="Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Huawei Cloud ASM Trace Data to Guance"
  				data-summary="Sending trace data from Huawei Cloud ASM to Guance for viewing and analysis."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_asm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud ASM Trace Data to Guance</div>
                            <div title="Sending trace data from Huawei Cloud ASM to Guance for viewing and analysis." class="fth-integration-desc">Sending trace data from Huawei Cloud ASM to Guance for viewing and analysis.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Collect Huawei Cloud CCE Metrics Data with Guance"
  				data-summary="Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_cce/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Collect Huawei Cloud CCE Metrics Data with Guance</div>
                            <div title="Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc." class="fth-integration-desc">Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The core performance Metrics of the Huawei Cloud Search Service CSS for Elasticsearch include query latency, indexing speed, search speed, disk usage, and CPU usage. These are key Metrics for evaluating and optimizing Elasticsearch performance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_css_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud Search Service CSS for Elasticsearch</div>
                            <div title="The core performance Metrics of the Huawei Cloud Search Service CSS for Elasticsearch include query latency, indexing speed, search speed, disk usage, and CPU usage. These are key Metrics for evaluating and optimizing Elasticsearch performance." class="fth-integration-desc">The core performance Metrics of the Huawei Cloud Search Service CSS for Elasticsearch include query latency, indexing speed, search speed, disk usage, and CPU usage. These are key Metrics for evaluating and optimizing Elasticsearch performance.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Huawei Cloud DCAAS Cloud Direct Connect</div>
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
                            <div class="fth-integration-name">Huawei Cloud DCS</div>
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
                            <div class="fth-integration-name">Huawei Cloud DDS</div>
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
  				data-summary="Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud DIS</div>
                            <div title="Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud ECS</div>
                            <div title="Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Huawei Cloud EIP</div>
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
  				data-summary="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud ELB</div>
                            <div title="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud GaussDB-Cassandra</div>
                            <div title="The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access." class="fth-integration-desc">The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="GaussDB for MySQL, including CPU, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_for_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud GaussDB for MySQL</div>
                            <div title="GaussDB for MySQL, including CPU, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics." class="fth-integration-desc">GaussDB for MySQL, including CPU, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policy, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_influx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud GaussDB-Influx</div>
                            <div title="The displayed metrics for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policy, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries." class="fth-integration-desc">The displayed metrics for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policy, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed Metrics of Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud GaussDB-Redis</div>
                            <div title="The displayed Metrics of Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching." class="fth-integration-desc">The displayed Metrics of Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data on CPU, memory, disk, deadlocks, SQL response time metrics, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_sys.gaussdbv5/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud GaussDB SYS.GAUSSDBV5</div>
                            <div title="Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data on CPU, memory, disk, deadlocks, SQL response time metrics, etc." class="fth-integration-desc">Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data on CPU, memory, disk, deadlocks, SQL response time metrics, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud DMS Kafka</div>
                            <div title="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Huawei Cloud MongoDB</div>
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
  				data-summary="Use the script packages in the Script Market, such as "Guance Cloud Sync", to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_obs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud OBS</div>
                            <div title="Use the script packages in the Script Market, such as "Guance Cloud Sync", to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the Script Market, such as "Guance Cloud Sync", to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud DMS RabbitMQ</div>
                            <div title="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance." class="fth-integration-desc">Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Huawei Cloud RDS MariaDB</div>
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
                            <div class="fth-integration-name">Huawei Cloud RDS MYSQL</div>
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
  				data-summary="The displayed Metrics for Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These Metrics reflect the performance and reliability of RDS PostgreSQL when handling large-scale relational data storage and transaction processing."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud RDS PostgreSQL</div>
                            <div title="The displayed Metrics for Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These Metrics reflect the performance and reliability of RDS PostgreSQL when handling large-scale relational data storage and transaction processing." class="fth-integration-desc">The displayed Metrics for Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These Metrics reflect the performance and reliability of RDS PostgreSQL when handling large-scale relational data storage and transaction processing.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Huawei Cloud RDS SQLServer</div>
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
  				data-summary="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud DMS RocketMQ</div>
                            <div title="Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance." class="fth-integration-desc">Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_roma/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud ROMA</div>
                            <div title="Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Huawei Cloud WAF Metrics Data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_waf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Huawei Cloud WAF Web Application Firewall</div>
                            <div title="Collect Huawei Cloud WAF Metrics Data" class="fth-integration-desc">Collect Huawei Cloud WAF Metrics Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect IIS Metrics Data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/iis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">IIS</div>
                            <div title="Collect IIS Metrics Data" class="fth-integration-desc">Collect IIS Metrics Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect log information with iLogtail"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ilogtail/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">iLogtail</div>
                            <div title="Collect log information with iLogtail" class="fth-integration-desc">Collect log information with iLogtail</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="InfluxDB"
  				data-summary="Collect InfluxDB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/influxdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">InfluxDB</div>
                            <div title="Collect InfluxDB Metrics data" class="fth-integration-desc">Collect InfluxDB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to Ingress Nginx (Prometheus)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ingress/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Ingress Nginx (Prometheus)</div>
                            <div title="Collect metrics related to Ingress Nginx (Prometheus)" class="fth-integration-desc">Collect metrics related to Ingress Nginx (Prometheus)</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="IPMI Metrics display information such as current, voltage, power consumption, occupancy rate, fan speed, temperature, and device status of the monitored equipment"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ipmi/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">IPMI</div>
                            <div title="IPMI Metrics display information such as current, voltage, power consumption, occupancy rate, fan speed, temperature, and device status of the monitored equipment" class="fth-integration-desc">IPMI Metrics display information such as current, voltage, power consumption, occupancy rate, fan speed, temperature, and device status of the monitored equipment</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Guance Incident is deeply integrated with DingTalk, making it easy to send incident information to DingTalk and reply through DingTalk, which will be transmitted back to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dingtalk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Incident - DingTalk</div>
                            <div title="Guance Incident is deeply integrated with DingTalk, making it easy to send incident information to DingTalk and reply through DingTalk, which will be transmitted back to Guance" class="fth-integration-desc">Guance Incident is deeply integrated with DingTalk, making it easy to send incident information to DingTalk and reply through DingTalk, which will be transmitted back to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Guance Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/feishu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Incident - Lark</div>
                            <div title="Guance Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to Guance" class="fth-integration-desc">Guance Incident is deeply integrated with Lark, making it easy to send incident information to Lark and reply through Lark, which will be transmitted back to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Istio</div>
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
  				data-tags="JAEGER,Trace Analysis"
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
                            <div class="fth-integration-name">Jaeger</div>
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
  				data-summary="Obtain metrics, trace data, and log information from JAVA applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JAVA</div>
                            <div title="Obtain metrics, trace data, and log information from JAVA applications" class="fth-integration-desc">Obtain metrics, trace data, and log information from JAVA applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Monitor browser user behavior using JavaScript (Web)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/javascript/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JavaScript</div>
                            <div title="Monitor browser user behavior using JavaScript (Web)" class="fth-integration-desc">Monitor browser user behavior using JavaScript (Web)</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics and logs from Jenkins"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jenkins/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Jenkins</div>
                            <div title="Collect metrics and logs from Jenkins" class="fth-integration-desc">Collect metrics and logs from Jenkins</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display JVM performance Metrics: heap and non-heap memory, threads, class loading counts, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JMX</div>
                            <div title="Display JVM performance Metrics: heap and non-heap memory, threads, class loading counts, etc." class="fth-integration-desc">Display JVM performance Metrics: heap and non-heap memory, threads, class loading counts, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics information related to JuiceFS data size, IO, transactions, objects, clients, and other components"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/juicefs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JuiceFS</div>
                            <div title="Collect metrics information related to JuiceFS data size, IO, transactions, objects, clients, and other components" class="fth-integration-desc">Collect metrics information related to JuiceFS data size, IO, transactions, objects, clients, and other components</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect JVM Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JVM</div>
                            <div title="Collect JVM Metrics data" class="fth-integration-desc">Collect JVM Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JMX Exporter</div>
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JMX Jolokia</div>
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non-heap memory, threads, number of classes loaded, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JMX Micrometer</div>
                            <div title="JVM performance metrics display: heap and non-heap memory, threads, number of classes loaded, etc." class="fth-integration-desc">JVM performance metrics display: heap and non-heap memory, threads, number of classes loaded, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">JMX StatsD</div>
                            <div title="JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc." class="fth-integration-desc">JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Middleware,Message Queue"
  				data-name="Kafka"
  				data-summary="Collect Kafka Metrics Data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kafka</div>
                            <div title="Collect Kafka Metrics Data" class="fth-integration-desc">Collect Kafka Metrics Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Message Queue,Logs"
  				data-name="KafkaMQ"
  				data-summary="Collect existing Metrics and log data via Kafka"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">KafkaMQ</div>
                            <div title="Collect existing Metrics and log data via Kafka" class="fth-integration-desc">Collect existing Metrics and log data via Kafka</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Kong</div>
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
  				data-name="Kube Proxy"
  				data-summary="By tracking the operational metrics of kube-proxy, it helps to understand the load, response time, synchronization status, and other information of the network proxy"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_proxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kube Proxy</div>
                            <div title="By tracking the operational metrics of kube-proxy, it helps to understand the load, response time, synchronization status, and other information of the network proxy" class="fth-integration-desc">By tracking the operational metrics of kube-proxy, it helps to understand the load, response time, synchronization status, and other information of the network proxy</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="By monitoring Kube Scheduler metrics, it helps configure and optimize the Kube Scheduler, which can improve cluster resource utilization and application performance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_scheduler/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kube Scheduler</div>
                            <div title="By monitoring Kube Scheduler metrics, it helps configure and optimize the Kube Scheduler, which can improve cluster resource utilization and application performance" class="fth-integration-desc">By monitoring Kube Scheduler metrics, it helps configure and optimize the Kube Scheduler, which can improve cluster resource utilization and application performance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect real-time cluster resource information using Kube State Metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kube_state_metrics/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kube State Metrics</div>
                            <div title="Collect real-time cluster resource information using Kube State Metrics" class="fth-integration-desc">Collect real-time cluster resource information using Kube State Metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">KubeCost</div>
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
  				data-href="../kubernetes-api-server"
  				data-tags="PROMETHEUS,KUBERNETES"
  				data-name="Kubernetes API Server"
  				data-summary="Collect metrics related to the Kubernetes API Server"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kubernetes API Server</div>
                            <div title="Collect metrics related to the Kubernetes API Server" class="fth-integration-desc">Collect metrics related to the Kubernetes API Server</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Kubernetes CRD</div>
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
  				data-summary="Collect Prometheus Metrics exposed by custom Pods in Kubernetes clusters"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kubernetes Prometheus Exporter</div>
                            <div title="Collect Prometheus Metrics exposed by custom Pods in Kubernetes clusters" class="fth-integration-desc">Collect Prometheus Metrics exposed by custom Pods in Kubernetes clusters</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Support for Prometheus-Operator CRD and collection of corresponding metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Prometheus CRD</div>
                            <div title="Support for Prometheus-Operator CRD and collection of corresponding metrics" class="fth-integration-desc">Support for Prometheus-Operator CRD and collection of corresponding metrics</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Kubernetes Audit Log Collection</div>
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
  				data-summary="Supports discovering and collecting Prometheus metrics exposed in Kubernetes"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Kubernetes Prometheus Discovery</div>
                            <div title="Supports discovering and collecting Prometheus metrics exposed in Kubernetes" class="fth-integration-desc">Supports discovering and collecting Prometheus metrics exposed in Kubernetes</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">LangChain</div>
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
  				data-tags="KUBERNETES,Logs,Container"
  				data-name="Log Sidecar"
  				data-summary="Sidecar-based log collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Log Sidecar</div>
                            <div title="Sidecar-based log collection" class="fth-integration-desc">Sidecar-based log collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="KUBERNETES,Logs,Containers"
  				data-name="Log Forward"
  				data-summary="Collect log data within Pods via sidecar method"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logfwd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Log Forward</div>
                            <div title="Collect log data within Pods via sidecar method" class="fth-integration-desc">Collect log data within Pods via sidecar method</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Logs"
  				data-name="Log Collection"
  				data-summary="Collect log data from hosts"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logging/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Log Collection</div>
                            <div title="Collect log data from hosts" class="fth-integration-desc">Collect log data from hosts</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Logging"
  				data-name="Socket Logging"
  				data-summary="This document mainly describes how to configure Socket in Java/Go/Python logging frameworks to send logs to the Datakit log collector."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/socket/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Socket Logging</div>
                            <div title="This document mainly describes how to configure Socket in Java/Go/Python logging frameworks to send logs to the Datakit log collector." class="fth-integration-desc">This document mainly describes how to configure Socket in Java/Go/Python logging frameworks to send logs to the Datakit log collector.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Logstash</div>
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
  				data-tags="Logs"
  				data-name="Log Streaming"
  				data-summary="Submit log data via HTTP"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logstreaming/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Log Streaming</div>
                            <div title="Submit log data via HTTP" class="fth-integration-desc">Submit log data via HTTP</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Lsblk"
  				data-summary="Collect metrics data from block devices"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/disk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Lsblk</div>
                            <div title="Collect metrics data from block devices" class="fth-integration-desc">Collect metrics data from block devices</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Memory"
  				data-summary="Collect metrics data from host memory"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Memory</div>
                            <div title="Collect metrics data from host memory" class="fth-integration-desc">Collect metrics data from host memory</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Cache,Middleware"
  				data-name="Memcached"
  				data-summary="Collect metrics data from Memcached"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Memcached</div>
                            <div title="Collect metrics data from Memcached" class="fth-integration-desc">Collect metrics data from Memcached</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to the Milvus vector database"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/milvus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Milvus Vector Database</div>
                            <div title="Collect metrics related to the Milvus vector database" class="fth-integration-desc">Collect metrics related to the Milvus vector database</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to MinIO"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/minio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">MinIO</div>
                            <div title="Collect metrics related to MinIO" class="fth-integration-desc">Collect metrics related to MinIO</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect MinIO related Metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/minio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">MinIO V3</div>
                            <div title="Collect MinIO related Metrics information" class="fth-integration-desc">Collect MinIO related Metrics information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="database"
  				data-name="MongoDB"
  				data-summary="Collect metrics data from MongoDB"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">MongoDB</div>
                            <div title="Collect metrics data from MongoDB" class="fth-integration-desc">Collect metrics data from MongoDB</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident Events and Jira Integration"
  				data-summary="When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira, this method provides better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this approach also helps us analyze and solve problems more effectively, improving system stability and reliability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/monitor_jira/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Incident Events and Jira Integration</div>
                            <div title="When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira, this method provides better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this approach also helps us analyze and solve problems more effectively, improving system stability and reliability." class="fth-integration-desc">When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to Jira to create issues, allowing us to track, analyze, and resolve these problems within Jira. By quickly sending incident events to Jira, this method provides better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this approach also helps us analyze and solve problems more effectively, improving system stability and reliability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">MQTT</div>
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
  				data-tags="Database"
  				data-name="MySQL"
  				data-summary="Collect metrics data from MySQL"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">MySQL</div>
                            <div title="Collect metrics data from MySQL" class="fth-integration-desc">Collect metrics data from MySQL</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics related to Nacos"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nacos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Nacos</div>
                            <div title="Collect metrics related to Nacos" class="fth-integration-desc">Collect metrics related to Nacos</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="Neo4j"
  				data-summary="Collect metrics data from Neo4j"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/neo4j/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Neo4j</div>
                            <div title="Collect metrics data from Neo4j" class="fth-integration-desc">Collect metrics data from Neo4j</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host,Network"
  				data-name="Net"
  				data-summary="Collect network interface metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/net/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Net</div>
                            <div title="Collect network interface metrics data" class="fth-integration-desc">Collect network interface metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Network"
  				data-name="NetFlow"
  				data-summary="The NetFlow collector can be used to visualize and monitor devices that have NetFlow enabled"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/netflow/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">NetFlow</div>
                            <div title="The NetFlow collector can be used to visualize and monitor devices that have NetFlow enabled" class="fth-integration-desc">The NetFlow collector can be used to visualize and monitor devices that have NetFlow enabled</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Network,Host"
  				data-name="NetStat"
  				data-summary="Collect network interface traffic Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/netstat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">NetStat</div>
                            <div title="Collect network interface traffic Metrics data" class="fth-integration-desc">Collect network interface traffic Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="NEWRELIC,Trace"
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
                            <div class="fth-integration-name">New Relic</div>
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
  				data-tags="Host"
  				data-name="NFS"
  				data-summary="NFS Metrics Collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nfs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">NFS</div>
                            <div title="NFS Metrics Collection" class="fth-integration-desc">NFS Metrics Collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="WEB SERVER,Middleware"
  				data-name="Nginx"
  				data-summary="Collect metrics data from Nginx"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nginx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Nginx</div>
                            <div title="Collect metrics data from Nginx" class="fth-integration-desc">Collect metrics data from Nginx</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Nginx Tracing</div>
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
  				data-summary="Collect host Metrics information via Node Exporter"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/node_exporter/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Node Exporter</div>
                            <div title="Collect host Metrics information via Node Exporter" class="fth-integration-desc">Collect host Metrics information via Node Exporter</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics, trace data, and logs from NodeJs applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/node_js/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">NodeJs</div>
                            <div title="Collect metrics, trace data, and logs from NodeJs applications" class="fth-integration-desc">Collect metrics, trace data, and logs from NodeJs applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Node Problem Detector</div>
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
  				data-tags="Message Queue,Middleware"
  				data-name="NSQ"
  				data-summary="Collect metrics data from NSQ"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nsq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">NSQ</div>
                            <div title="Collect metrics data from NSQ" class="fth-integration-desc">Collect metrics data from NSQ</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="OceanBase"
  				data-summary="Collect metrics data from OceanBase"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/oceanbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OceanBase</div>
                            <div title="Collect metrics data from OceanBase" class="fth-integration-desc">Collect metrics data from OceanBase</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for OpenAI include total requests, response time, request count, request error count, and consumed token count."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/openai/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenAI</div>
                            <div title="The displayed metrics for OpenAI include total requests, response time, request count, request error count, and consumed token count." class="fth-integration-desc">The displayed metrics for OpenAI include total requests, response time, request count, request error count, and consumed token count.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">OpenGauss</div>
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
  				data-tags="OTEL,Trace Linking"
  				data-name="OpenLIT"
  				data-summary="OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/openlit/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenLIT</div>
                            <div title="OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to Guance" class="fth-integration-desc">OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="GOLANG,OTEL,Tracing"
  				data-name="OpenTelemetry Golang"
  				data-summary="Integration of OpenTelemetry Golang"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenTelemetry Golang</div>
                            <div title="Integration of OpenTelemetry Golang" class="fth-integration-desc">Integration of OpenTelemetry Golang</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="JAVA,OTEL,Tracing"
  				data-name="OpenTelemetry Java"
  				data-summary="OpenTelemetry Java Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenTelemetry Java</div>
                            <div title="OpenTelemetry Java Integration" class="fth-integration-desc">OpenTelemetry Java Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Python,OTEL,Tracing"
  				data-name="OpenTelemetry Python"
  				data-summary="OpenTelemetry Python integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenTelemetry Python</div>
                            <div title="OpenTelemetry Python integration" class="fth-integration-desc">OpenTelemetry Python integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="OTEL,Trace Analysis"
  				data-name="OpenTelemetry"
  				data-summary="Receive OpenTelemetry Metrics, logs, APM data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenTelemetry</div>
                            <div title="Receive OpenTelemetry Metrics, logs, APM data" class="fth-integration-desc">Receive OpenTelemetry Metrics, logs, APM data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="Oracle"
  				data-summary="Collect metrics data from Oracle"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/oracle/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Oracle</div>
                            <div title="Collect metrics data from Oracle" class="fth-integration-desc">Collect metrics data from Oracle</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="OTEL,Tracing"
  				data-name="OpenTelemetry Extension"
  				data-summary="Guance has made additional extensions to the OpenTelemetry plugin"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">OpenTelemetry Extension</div>
                            <div title="Guance has made additional extensions to the OpenTelemetry plugin" class="fth-integration-desc">Guance has made additional extensions to the OpenTelemetry plugin</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Guance OpenTelemetry Exporter"
  				data-summary="Directly export OpenTelemetry data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Guance OpenTelemetry Exporter</div>
                            <div title="Directly export OpenTelemetry data to Guance" class="fth-integration-desc">Directly export OpenTelemetry data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Incident Events and PagerDuty Integration"
  				data-summary="When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to PagerDuty to create incidents. This allows us to track, analyze, and resolve issues within PagerDuty, providing better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this method also helps us better analyze and solve problems, improving system stability and reliability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pagerduty/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Incident Events and PagerDuty Integration</div>
                            <div title="When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to PagerDuty to create incidents. This allows us to track, analyze, and resolve issues within PagerDuty, providing better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this method also helps us better analyze and solve problems, improving system stability and reliability." class="fth-integration-desc">When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to PagerDuty to create incidents. This allows us to track, analyze, and resolve issues within PagerDuty, providing better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this method also helps us better analyze and solve problems, improving system stability and reliability.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Get metrics, trace data, and log information from PHP applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/php/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">PHP</div>
                            <div title="Get metrics, trace data, and log information from PHP applications" class="fth-integration-desc">Get metrics, trace data, and log information from PHP applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,GOLANG,Trace Analysis"
  				data-name="PinPoint Golang"
  				data-summary="PinPoint Golang Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">PinPoint Golang</div>
                            <div title="PinPoint Golang Integration" class="fth-integration-desc">PinPoint Golang Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,JAVA,Trace Analysis"
  				data-name="PinPoint Java"
  				data-summary="PinPoint Java Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">PinPoint Java</div>
                            <div title="PinPoint Java Integration" class="fth-integration-desc">PinPoint Java Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="PINPOINT,Trace Analysis"
  				data-name="Pinpoint"
  				data-summary="Pinpoint Tracing Data Ingestion"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pinpoint/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Pinpoint</div>
                            <div title="Pinpoint Tracing Data Ingestion" class="fth-integration-desc">Pinpoint Tracing Data Ingestion</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Receive data to be processed from DataKit Pipeline Offload"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ploffload/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Pipeline Offload</div>
                            <div title="Receive data to be processed from DataKit Pipeline Offload" class="fth-integration-desc">Receive data to be processed from DataKit Pipeline Offload</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="PostgreSQL"
  				data-summary="Collect metrics data from PostgreSQL"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">PostgreSQL</div>
                            <div title="Collect metrics data from PostgreSQL" class="fth-integration-desc">Collect metrics data from PostgreSQL</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="C++ Profiling Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling C++</div>
                            <div title="C++ Profiling Integration" class="fth-integration-desc">C++ Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Profiling .Net</div>
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
  				data-name="Profiling Golang"
  				data-summary="Golang Profiling Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling Golang</div>
                            <div title="Golang Profiling Integration" class="fth-integration-desc">Golang Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Java Profiling Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling Java</div>
                            <div title="Java Profiling Integration" class="fth-integration-desc">Java Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="NodeJS Profiling Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling NodeJS</div>
                            <div title="NodeJS Profiling Integration" class="fth-integration-desc">NodeJS Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Profiling PHP</div>
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
  				data-summary="Python Profiling Integration"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling Python</div>
                            <div title="Python Profiling Integration" class="fth-integration-desc">Python Profiling Integration</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect runtime performance data of applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Profiling</div>
                            <div title="Collect runtime performance data of applications" class="fth-integration-desc">Collect runtime performance data of applications</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion,PROMETHEUS"
  				data-name="Prometheus Exporter"
  				data-summary="Collect metrics data exposed by Prometheus Exporters"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/prometheus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Prometheus Exporter</div>
                            <div title="Collect metrics data exposed by Prometheus Exporters" class="fth-integration-desc">Collect metrics data exposed by Prometheus Exporters</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion,PROMETHEUS"
  				data-name="Prometheus Remote Write"
  				data-summary="Collect metrics data via Prometheus Remote Write"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/prometheus/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Prometheus Remote Write</div>
                            <div title="Collect metrics data via Prometheus Remote Write" class="fth-integration-desc">Collect metrics data via Prometheus Remote Write</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion"
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
                            <div class="fth-integration-name">Promtail</div>
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
  				data-tags="PROXY"
  				data-name="Proxy"
  				data-summary="Proxy Datakit’s HTTP requests"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/proxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Proxy</div>
                            <div title="Proxy Datakit’s HTTP requests" class="fth-integration-desc">Proxy Datakit’s HTTP requests</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion,PROMETHEUS"
  				data-name="Prometheus Push Gateway"
  				data-summary="Enable the Pushgateway API to receive Prometheus Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pushgateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Prometheus Push Gateway</div>
                            <div title="Enable the Pushgateway API to receive Prometheus Metrics data" class="fth-integration-desc">Enable the Pushgateway API to receive Prometheus Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Grafana Pyroscope application performance collector"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/profiling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Pyroscope</div>
                            <div title="Grafana Pyroscope application performance collector" class="fth-integration-desc">Grafana Pyroscope application performance collector</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect data via Python extensions"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pythond/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Pythond</div>
                            <div title="Collect data via Python extensions" class="fth-integration-desc">Collect data via Python extensions</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Tool for importing Grafana Dashboard templates into Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/grafance_import/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Grafana Dashboard Import</div>
                            <div title="Tool for importing Grafana Dashboard templates into Guance" class="fth-integration-desc">Tool for importing Grafana Dashboard templates into Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Message Queue,Middleware"
  				data-name="RabbitMQ"
  				data-summary="Collect metrics data from RabbitMQ"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">RabbitMQ</div>
                            <div title="Collect metrics data from RabbitMQ" class="fth-integration-desc">Collect metrics data from RabbitMQ</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Ranger Admin Metrics Information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ranger/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Ranger Admin</div>
                            <div title="Collect Ranger Admin Metrics Information" class="fth-integration-desc">Collect Ranger Admin Metrics Information</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Ranger Tagsync</div>
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
                            <div class="fth-integration-name">Ranger Usersync</div>
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
                            <div class="fth-integration-name">Redis Sentinel</div>
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
  				data-tags="Cache,Middleware"
  				data-name="Redis"
  				data-summary="Redis Metrics and Log Collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Redis</div>
                            <div title="Redis Metrics and Log Collection" class="fth-integration-desc">Redis Metrics and Log Collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Resin performance Metrics, including startup time, heap memory, non-heap memory, classes, threads, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/resin/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Resin</div>
                            <div title="Display of Resin performance Metrics, including startup time, heap memory, non-heap memory, classes, threads, etc." class="fth-integration-desc">Display of Resin performance Metrics, including startup time, heap memory, non-heap memory, classes, threads, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">RocketMQ</div>
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
                            <div class="fth-integration-name">RUM</div>
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
                            <div class="fth-integration-name">Seata</div>
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
  				data-tags="Security"
  				data-name="SCheck"
  				data-summary="Receive data collected by SCheck"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/scheck/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">SCheck</div>
                            <div title="Receive data collected by SCheck" class="fth-integration-desc">Receive data collected by SCheck</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Hardware Sensors Data Collection"
  				data-summary="Collect hardware temperature metrics using the Sensors command"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/sensors/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Hardware Sensors Data Collection</div>
                            <div title="Collect hardware temperature metrics using the Sensors command" class="fth-integration-desc">Collect hardware temperature metrics using the Sensors command</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Tracing,SKYWALKING"
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
                            <div class="fth-integration-name">SkyWalking</div>
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
  				data-tags="Host"
  				data-name="Disk S.M.A.R.T"
  				data-summary="Collect disk metrics using `smartctl`"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/smartctl/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Disk S.M.A.R.T</div>
                            <div title="Collect disk metrics using `smartctl`" class="fth-integration-desc">Collect disk metrics using `smartctl`</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">SNMP</div>
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
  				data-tags="Network"
  				data-name="Socket"
  				data-summary="Collect metrics data from TCP/UDP ports"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/socket/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Socket</div>
                            <div title="Collect metrics data from TCP/UDP ports" class="fth-integration-desc">Collect metrics data from TCP/UDP ports</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="Solr"
  				data-summary="Collect metrics data from Solr"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/solr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Solr</div>
                            <div title="Collect metrics data from Solr" class="fth-integration-desc">Collect metrics data from Solr</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="SQLServer"
  				data-summary="Collect metrics data from SQLServer"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">SQLServer</div>
                            <div title="Collect metrics data from SQLServer" class="fth-integration-desc">Collect metrics data from SQLServer</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="SSH"
  				data-summary="Collect metrics data from SSH"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ssh/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">SSH</div>
                            <div title="Collect metrics data from SSH" class="fth-integration-desc">Collect metrics data from SSH</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion"
  				data-name="StatsD"
  				data-summary="Collect metrics data reported by StatsD"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/statsd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">StatsD</div>
                            <div title="Collect metrics data reported by StatsD" class="fth-integration-desc">Collect metrics data reported by StatsD</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="Swap"
  				data-summary="Collect metrics data from host swap memory"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/swap/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Swap</div>
                            <div title="Collect metrics data from host swap memory" class="fth-integration-desc">Collect metrics data from host swap memory</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Host"
  				data-name="System"
  				data-summary="Collect metrics data related to the host system"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/system/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">System</div>
                            <div title="Collect metrics data related to the host system" class="fth-integration-desc">Collect metrics data related to the host system</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Database"
  				data-name="TDengine"
  				data-summary="Collect Metrics data from TDengine"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tdengine/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">TDengine</div>
                            <div title="Collect Metrics data from TDengine" class="fth-integration-desc">Collect Metrics data from TDengine</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Integration"
  				data-name="Telegraf"
  				data-summary="Receive data collected by Telegraf"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/telegraf/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Telegraf</div>
                            <div title="Receive data collected by Telegraf" class="fth-integration-desc">Receive data collected by Telegraf</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages from the official script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud CDB</div>
                            <div title="Use the script packages from the official script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages from the official script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of CKafka in handling large-scale message delivery and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_ckafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud CKafka</div>
                            <div title="The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of CKafka in handling large-scale message delivery and real-time data streams." class="fth-integration-desc">The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of CKafka in handling large-scale message delivery and real-time data streams.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of the Guance cloud synchronization series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud CLB Private</div>
                            <div title="Use the script packages in the script market of the Guance cloud synchronization series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of the Guance cloud synchronization series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud CLB Public</div>
                            <div title="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the Script Market of Guance series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud COS</div>
                            <div title="Use the script packages in the Script Market of Guance series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the Script Market of Guance series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud CVM</div>
                            <div title="Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Tencent Cloud KeeWiDB metrics display, including connections, requests, cache, keys, slow queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_keewidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud KeeWiDB</div>
                            <div title="Tencent Cloud KeeWiDB metrics display, including connections, requests, cache, keys, slow queries, etc." class="fth-integration-desc">Tencent Cloud KeeWiDB metrics display, including connections, requests, cache, keys, slow queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud MariaDB</div>
                            <div title="Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud Memcached</div>
                            <div title="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the script packages in the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud MongoDB</div>
                            <div title="Use the script packages in the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the script packages in the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud PostgreSQL</div>
                            <div title="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_redis_mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud Redis</div>
                            <div title="Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc." class="fth-integration-desc">Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud SQLServer</div>
                            <div title="Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_tdsql_c_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tencent Cloud TDSQL_C_MySQL</div>
                            <div title="Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance" class="fth-integration-desc">Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics information from TiDB cluster, TiDB, Etcd, Region, and other related components"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">TiDB</div>
                            <div title="Collect metrics information from TiDB cluster, TiDB, Etcd, Region, and other related components" class="fth-integration-desc">Collect metrics information from TiDB cluster, TiDB, Etcd, Region, and other related components</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="WEB SERVER,Middleware"
  				data-name="Tomcat"
  				data-summary="Collect metrics data from Tomcat"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tomcat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tomcat</div>
                            <div title="Collect metrics data from Tomcat" class="fth-integration-desc">Collect metrics data from Tomcat</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Trace Propagation"
  				data-name="Tracing Propagator"
  				data-summary="Mechanism and usage of information propagation in multiple traces"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Tracing Propagator</div>
                            <div title="Mechanism and usage of information propagation in multiple traces" class="fth-integration-desc">Mechanism and usage of information propagation in multiple traces</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
                            <div class="fth-integration-name">Trino</div>
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
  				data-summary="VMware displays metrics such as cluster status, host status, VM status, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/vmware/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VMware</div>
                            <div title="VMware displays metrics such as cluster status, host status, VM status, etc." class="fth-integration-desc">VMware displays metrics such as cluster status, host status, VM status, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine ALB"
  				data-summary="Collect VolcEngine ALB Metrics Data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_alb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine ALB</div>
                            <div title="Collect VolcEngine ALB Metrics Data" class="fth-integration-desc">Collect VolcEngine ALB Metrics Data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volc Engine"
  				data-name="Volc Engine CLB"
  				data-summary="Collect Volc Engine CLB Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Volc Engine CLB</div>
                            <div title="Collect Volc Engine CLB Metrics data" class="fth-integration-desc">Collect Volc Engine CLB Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine ECS"
  				data-summary="The displayed Metrics of VolcEngine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine ECS</div>
                            <div title="The displayed Metrics of VolcEngine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage." class="fth-integration-desc">The displayed Metrics of VolcEngine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Volc Engine"
  				data-name="Volc Engine EIP"
  				data-summary="Collect Volc Engine EIP metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Volc Engine EIP</div>
                            <div title="Collect Volc Engine EIP metrics data" class="fth-integration-desc">Collect Volc Engine EIP metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine MongoDB Replica Set"
  				data-summary="Displays VolcEngine MongoDB replica set metrics, including CPU usage, memory usage, connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine MongoDB Replica Set</div>
                            <div title="Displays VolcEngine MongoDB replica set metrics, including CPU usage, memory usage, connections, latency, OPS, etc." class="fth-integration-desc">Displays VolcEngine MongoDB replica set metrics, including CPU usage, memory usage, connections, latency, OPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine MongoDB Sharded Cluster"
  				data-summary="Displays metrics for the VolcEngine MongoDB sharded cluster, including CPU usage, memory usage, connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine MongoDB Sharded Cluster</div>
                            <div title="Displays metrics for the VolcEngine MongoDB sharded cluster, including CPU usage, memory usage, connections, latency, OPS, etc." class="fth-integration-desc">Displays metrics for the VolcEngine MongoDB sharded cluster, including CPU usage, memory usage, connections, latency, OPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine MySQL"
  				data-summary="VolcEngine MySQL metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine MySQL</div>
                            <div title="VolcEngine MySQL metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc." class="fth-integration-desc">VolcEngine MySQL metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine NAS File Storage"
  				data-summary="Collect VolcEngine NAS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_nas/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine NAS File Storage</div>
                            <div title="Collect VolcEngine NAS Metrics data" class="fth-integration-desc">Collect VolcEngine NAS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine Redis"
  				data-summary="VolcEngine Redis Metrics Collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine Redis</div>
                            <div title="VolcEngine Redis Metrics Collection" class="fth-integration-desc">VolcEngine Redis Metrics Collection</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine TOS Object Storage"
  				data-summary="Collect VolcEngine TOS Metrics data"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_tos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine TOS Object Storage</div>
                            <div title="Collect VolcEngine TOS Metrics data" class="fth-integration-desc">Collect VolcEngine TOS Metrics data</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="VolcEngine"
  				data-name="VolcEngine VKE"
  				data-summary="VolcEngine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_vke/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">VolcEngine VKE</div>
                            <div title="VolcEngine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc." class="fth-integration-desc">VolcEngine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics data from vSphere"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/vsphere/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">vSphere</div>
                            <div title="Collect metrics data from vSphere" class="fth-integration-desc">Collect metrics data from vSphere</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Windows Events"
  				data-summary="Collecting event logs from Windows"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/winevent/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Windows Events</div>
                            <div title="Collecting event logs from Windows" class="fth-integration-desc">Collecting event logs from Windows</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect quota information from the xfs file system"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">xfsquota</div>
                            <div title="Collect quota information from the xfs file system" class="fth-integration-desc">Collect quota information from the xfs file system</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="External Data Ingestion"
  				data-name="Zabbix Data Ingestion"
  				data-summary="Zabbix real-time data ingestion"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zabbix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Zabbix Data Ingestion</div>
                            <div title="Zabbix real-time data ingestion" class="fth-integration-desc">Zabbix real-time data ingestion</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Zadigx displays metrics including Overview, automated builds, automated deployments, and automated testing."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zadigx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<div class="fth-integration-description">
                            <div class="fth-integration-name">Zadigx</div>
                            <div title="Zadigx displays metrics including Overview, automated builds, automated deployments, and automated testing." class="fth-integration-desc">Zadigx displays metrics including Overview, automated builds, automated deployments, and automated testing.</div>
                        </div>
                        <div class="fth-integration-mask-image"></div>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="ZIPKIN,Tracing"
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
                            <div class="fth-integration-name">Zipkin</div>
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
                            <div class="fth-integration-name">ZooKeeper</div>
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
            const limitTags = ['阿里云', '腾讯云', '华为云', '火山引擎','谷歌云', 'AWS', 'AZURE', '中间件', '主机', 'IPMI', 'KUBERNETES', '容器', '网络', 'EBPF', 'BPF', 'SNMP', 'PROMETHEUS', 'ZABBIX', 'TELEGRAF', '缓存', '消息队列', '数据库', '语言', '链路追踪', 'PROFILE', '日志', '拨测', 'WEB', '移动端', 'CI/CD', 'JENKINS', 'GITLAB', '会话重放', 'WINDOWS'];
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
  						((!tags && !tag) || tags.includes(tag)) && (!name || name.includes(search) || summary.includes(search) || tags.includes(search));
  					dom.style.display = show ? 'block' : 'none';
  					// 如果是搜索触发 需重新计算tags
  					if (isSearch && show && tags) {
  						const tagsArr = tags.split(',');
  						tagsArr.forEach(v => {
  							if (tagObj[v]) {
  								tagObj[v] += 1;
  							} else {
  								tagObj[v] = 1;
  							}
  						});
  					}
  				});
  				if (isSearch) {
  					tagValue = '';
  					const tagContainer = header.querySelector('.integration-tags-group');
  					if (Object.keys(tagObj).length) {
  						const tags = Object.entries(tagObj).reduce(
                                (acc, cur) => {
                                    const [key, value] = cur;
                                    const keyIndex = limitTags.indexOf(key);
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
                                `<div class="integration-tags-group-item ${
                                tag.label === tagAll.label ? 'tag-active' : ''
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
  					originList.push({ tags, name, summary, dom: item });
  				});
  				searchIntegration();
  			}
  			init();
  		})();
  	</script>
  </div>
</html>
<!-- markdownlint-enable -->
