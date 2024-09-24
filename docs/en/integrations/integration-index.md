---
icon: zy/integrations
---

# Integrations

---

Guance has the ability of full stack data collection, and now supports about 270 integrations.

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
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-left img {
  			width: 32px;
  			height: 32px;
  			border-style: none;
  		}
  		.fth-integration-list-content .fth-integration-list-item .integration-list-item-left .fth-integration-name {
  			max-width: 184px;
  			font-size: 14px;
  			font-weight: 500;
  			line-height: 20px;
  			height: 20px;
  			text-overflow: ellipsis;
  			overflow: hidden;
  			white-space: nowrap;
  			margin-left: 10px;
  			color: #222;
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
  				data-summary="Collect Active Directory related metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/active_directory/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Active Directory</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collecting Aerospike-related metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aerospike/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aerospike</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun ClickHouse Community"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_clickhouse_community/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun ClickHouse Community</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="Alibaba Cloud"
  				data-name="Aliyun ECS"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun ECS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun EIP"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_eip/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun EIP</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun ElasticSearch"
  				data-summary="Aliyun ElasticSearch metrics display, including cluster status, index QPS, node CPU/memory/disk utilization and so on."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun ElasticSearch</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Kafka"
  				data-summary="AliCloud Kafka's presentation metrics include message throughput, latency, number of concurrent connections, and reliability, which reflect Kafka's performance performance and reliability guarantees when dealing with large-scale messaging and real-time data streams."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Kafka</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Lindorm"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_lindorm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Lindorm</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags="aliyun,mongodb"
  				data-name="Alibaba Cloud MongoDB"
  				data-summary="Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space, log disk space, statement execution times per second, requests, connections, network traffic, replication latency, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Alibaba Cloud MongoDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun NAT"
  				data-summary="Aliyun NAT Metrics, including the number of concurrent connections, number of new connections, VPC traffic, and VPC data packets。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_nat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun NAT</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun DDoS New BGP High Defense"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_nat/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun DDoS New BGP High Defense</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun OSS"
  				data-summary="Aliyun OSS metrics display, including request volume, availability, network traffic, request ratio, and more."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_oss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun OSS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun  PolarDB 1.0"
  				data-summary="Aliyun PolarDB Distributed 1.0 displays metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb_1.0/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun  PolarDB 1.0</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun PolarDB distributed2.0"
  				data-summary="Aliyun PolarDB distributed2.0 displays metrics of the computing layer and storage nodes, including CPU usage, connection usage, disk usage, disk usage, memory usage, and network bandwidth."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb_2.0/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun PolarDB distributed2.0</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun PolarDB MySQL"
  				data-summary="Aliyun PolarDB MySQL Metrics Display, including CPU usage, memory hit rate, network traffic, connection count, QPS (Queries Per Second), TPS (Transactions Per Second), and read-only node latency."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun PolarDB MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun PolarDB Oracle"
  				data-summary="Aliyun PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb_oracle/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun PolarDB Oracle</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun PolarDB PostgreSQL"
  				data-summary="Aliyun PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_polardb_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun PolarDB PostgreSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun RDS MariaDB"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun RDS MariaDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun RDS MySQL"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun RDS MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="AliCloud RDS PostgreSQL"
  				data-summary="AliCloud RDS PostgreSQL metrics showcase, including CPU utilization, memory usage, and more."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AliCloud RDS PostgreSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun RDS SQLServer"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rds_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun RDS SQLServer</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Redis Standard"
  				data-summary="Aliyun Redis Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Redis Standard</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Redis Shard"
  				data-summary="Aliyun Redis Shard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Redis Shard</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun RocketMQ4"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq4/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun RocketMQ4</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun RocketMQ 5"
  				data-summary="Aliyun RocketMQ 5.0 display metrics including message throughput, latency, reliability, and horizontal scalability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_rocketmq5/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun RocketMQ 5</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Site Monitor"
  				data-summary="Alibaba Cloud site monitoring mainly obtains site call testing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_site/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Site Monitor</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Aliyun Tair Standard"
  				data-summary="Aliyun Tair Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aliyun_tair/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Aliyun Tair Standard</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Apache</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collecting APISIX metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apisix/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">APISIX</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect information about Apollo-related metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/apollo/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Apollo</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Argo CD service status, application status, logs, and link information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/argocd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">ArgoCD</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect AutoMQ related metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/automq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AutoMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_api_gateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS API Gateway</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  							<path
  								d="M13.22 19.03a.75.75 0 0 1 0-1.06L18.19 13H3.75a.75.75 0 0 1 0-1.5h14.44l-4.97-4.97a.749.749 0 0 1 .326-1.275.749.749 0 0 1 .734.215l6.25 6.25a.75.75 0 0 1 0 1.06l-6.25 6.25a.75.75 0 0 1-1.06 0Z"
  							></path>
  						</svg>
  					</div>
  				</div>
  			</div>
  		
  			<div
  				class="fth-integration-list-item"
  				data-href="../aws_aurora_serverless_v2"
  				data-tags="AWS"
  				data-name="AWS Aurora Serverless V2"
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_aurora_serverless_v2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Aurora Serverless V2</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_auto_scaling/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Auto Scaling</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_cloudfront/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS CloudFront</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dms/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS DMS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_documentdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS DocumentDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance ."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS DynamoDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The display metrics of AWS DynamoDB DAX include CPU usage of nodes or clusters, number of bytes received or sent on all network interfaces, number of packets, etc. These metrics reflect the running status of DynamoDB DAX."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_dynamodb_DAX/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS DynamoDB DAX</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS EC2</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ec2_spot/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Amazon EC2 Spot</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The Amazon ECS feature is integrated with the Amazon Cloud Technology Fargate serverless computing engine, using observation clouds to monitor the operational status of its services."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS ECS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS ElastiCache Redis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_elasticache_serverless/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS ElastiCache Serverless</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_api_gateway/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS ELB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_emr/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS EMR</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance   Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance ."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_eventbridge/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS EventBridge</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Kinesis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_kinesis_analytics/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS KinesisAnalytics</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_lambda/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Lambda</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS MediaConvert, including data transfer, video errors, job count, padding, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_mediaconvert/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS MediaConvert</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_memorydb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS MemoryDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Amazon MQ supports industry standard APIs and protocols to manage and maintain message brokers, and automatically provides infrastructure for high availability."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_mq_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Amazon MQ for RabbitMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS MSK metrics collection"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_msk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS MSK</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_neptune_cluster/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Neptune Cluster</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_opensearch/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS OpenSearch</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS RDS MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance ."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_redshift/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Redshift</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_s3/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS S3</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS Simple Queue Service displaed metrics include the approximate age of the oldest non-deleted message in the queue, the number of messages in the queue that are delayed and not available for reading immediately, the number of messages that are in flight, the number of messages to be processed, and so on."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_sqs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Simple Queue Service</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="AWS Timestream displays the metrics include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and the current AWS account, the time elapsed for successful requests and the number of samples, the amount of data stored in memory, and the amount of data stored in magnetic storage."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/aws_timestream/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">AWS Timestream</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">AWS Lambda Extension</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Filebeat</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Cassandra</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Dianping CAT</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Chrony</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">ClickHouse</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Cloudprober</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">CockroachDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Consul</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Container Logs"
  				data-summary="Collect container and Kubernetes log"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Container Logs</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Basic Collection Of Containers"
  				data-summary="Collect metrics, objects, and log data for Container and Kubernetes, and report them to the guance cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Basic Collection Of Containers</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">CoreDNS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The collector can take many metrics from CouchBase instance, such as the memory and disk used by the data, the number of current connections and other metrics, and collect the metrics into the observation cloud to help monitor and analyze various anomalies in CouchBase. "
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/couchbase/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">CouchBase Exporter</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Couchbase</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">CouchDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">CPU</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DB2</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace Attach </span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace C++</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="GuanceCloud Extensions on DDTrace"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">DDTrace Extensions</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace Golang</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace Java</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace JMX</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace NodeJS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace PHP</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="DDTrace Phthon"
  				data-summary="Tracing Python applications with DDTrace"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ddtrace/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">DDTrace Phthon</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace Ruby</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DDTrace</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Diatesting</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Customize Dialtesting</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Disk</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Disk IO</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">DataKit metrics</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Dameng Database（DM8）"
  				data-summary="Collect information about Dameng Database metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Dameng Database（DM8）</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Dongfangtong THS（TongHttpServer）"
  				data-summary="Collect information about Dongfangtong THS（TongHttpServer） metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Dongfangtong THS（TongHttpServer）</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Dongfangtong TWeb（TongWeb）"
  				data-summary="Collect information about Dongfangtong TWeb（TongWeb） metrics and tracing"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dongfangtong/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Dongfangtong TWeb（TongWeb）</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Doris</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect relevant metrics, traces, logs, and profiling information for.NET applications through DDTrace"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dotnet/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">.NET</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">eBPF</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">eBPF Tracing</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">ElasticSearch</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect EMQX collection, topics, subsriptions, message, package related metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/emqx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">EMQX</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">etcd</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Exchange related metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/exchange/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Exchange</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">External</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Lark and Exception Tracking Integration</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Flink</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Fluentd Logs"
  				data-summary="Collect Fluentd logs"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/fluentd/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Fluentd Logs</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">GitLab</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Obtain metrics, link tracking, and log information for Golang applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/go/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Golang</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">GPU</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Graphite Exporter</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect metrics of Haproxy"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/haproxy/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Haproxy</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Health Check</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Process</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Host Directory</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Host Object</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI FunctionGraph"
  				data-summary="Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_functiongraph/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI FunctionGraph</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_SYS.AS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI AS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI CBR"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_SYS.CBR/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI CBR</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DDM"
  				data-summary="The HUAWEI CLOUD DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of DDMS in handling large-scale message delivery and real-time data flow."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huaweiyun_SYS_DDMS/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DDM</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI API Gateway"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the APIervation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_API/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI API Gateway</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI ASM"
  				data-summary="The link tracking data from HUAWEI CLOUD ASM is exported to Guance for viewing and analysis"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_asm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI ASM</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI CCE"
  				data-summary="Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, and more."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_cce/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI CCE</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI CSS for Elasticsearch"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_css_es/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI CSS for Elasticsearch</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DCS"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dcs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DCS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DIS"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_dis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DIS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI ECS"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI ECS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI ELB"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_elb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI ELB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI GaussDB-Cassandra"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_cassandra/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI GaussDB-Cassandra</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI GaussDB for MySQL"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/gaussdb_for_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI GaussDB for MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI GaussDB-Influx"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/HUAWEI CLOUD_gaussdb_influx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI GaussDB-Influx</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI GaussDB-Redis"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI GaussDB-Redis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI GaussDB SYS.GAUSSDBV5"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_gaussdb_sys.gaussdbv5/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI GaussDB SYS.GAUSSDBV5</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DMS Kafka"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_kafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DMS Kafka</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI MongoDB"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI MongoDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI OBS"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_obs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI OBS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DMS RabbitMQ"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rabbitmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DMS RabbitMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI RDS MYSQL"
  				data-summary="Use the「Guanc Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI RDS MYSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI RDS PostgreSQL"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rds_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI RDS PostgreSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI DMS RocketMQ"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI DMS RocketMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="HUAWEI ROMA"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/huawei_roma/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">HUAWEI ROMA</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Huawei Cloud SYS.DDMS Monitoring View</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">IIS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">iLogtail</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">InfluxDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Ingress Nginx (Prometheus) related metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/ingress/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Ingress Nginx (Prometheus)</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">IPMI</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Guance Exception Tracking (issue) - Dingtalk"
  				data-summary="Guance anomaly tracking is integrated with DingTalk depth, making it convenient to send anomaly tracking information to DingTalk, reply through DingTalk, and send it back to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/dingtalk/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Guance Exception Tracking (issue) - Dingtalk</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Guance Exception Tracking (issue) - Feishu"
  				data-summary="Guance anomaly tracking is integrated with Feishu depth, making it convenient to send anomaly tracking information to Feishu, reply through Feishu, and send it back to the Guance"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/feishu/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Guance Exception Tracking (issue) - Feishu</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Istio performance metric display, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Istio</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Jaeger</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Get metrics, link tracking, and log information for JAVA applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JAVA</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Monitoring browser usage behavior through JavaScript (Web)"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/javascript/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JavaScript</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Jenkins</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non heap memory, threads, class load count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JMX</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect JuiceFS data size, IO, things, objects, clients and other related component metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/juicefs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JuiceFS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">JVM</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non heap memory, threads, class load count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JMX Exporter</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non heap memory, threads, class load count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JMX Jolokia</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non heap memory, threads, class load count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JMX Micrometer</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="JVM performance metrics display: heap and non heap memory, threads, class load count, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/jvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">JMX StatsD</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Kafka</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">KafkaMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=""
  				data-name="KubeCost"
  				data-summary="Collect KubeCost metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubecost/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">KubeCost</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=""
  				data-name="Kubernetes API Server"
  				data-summary="Collect information about Kubernetes API Server related metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Kubernetes API Server</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Kubernetes CRD Extended Collection</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Kubernetes Prometheus Exporter</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Kubernetes Prometheus CRD</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-tags=""
  				data-name="Kubernetes Audit"
  				data-summary="Kubernetes Audit"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Kubernetes Audit</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Kubernetes Prometheus Discovery</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Optimize LangChain usage: prompt sampling and performance and cost metrics."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/langchain/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">LangChain</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Sidecar for Pod Logging</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Log Forward Server</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Log Collector</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Socket Logging</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collecting logging through Logstash"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/logstash/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Logstash</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Log Streaming</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Memory</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Memcached</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect information about MinIO related metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/minio/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">MinIO</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">MongoDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Exception Events Integration with Jira"
  				data-summary="When our applications or systems encounter exceptions, it is important to handle them promptly to ensure the normal operation of the system. To better manage and track exception events, we can send these events to Jira to create issues. This allows us to track, analyze, and resolve these issues in Jira, providing us with better capabilities to manage and track exception events and ensure the normal operation of the system. Additionally, this approach helps us analyze and resolve issues more effectively, improving the stability and reliability of the system."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/monitor_jira/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Exception Events Integration with Jira</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Nacos related index information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nacos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Nacos</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Neo4j</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Network</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">NetFlow</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">NetStat</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">New Relic</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Nginx</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Nginx tracing information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nginx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Nginx Tracing</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Obtain metrics, link tracking, and log information for NodeJs applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/nodejs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">NodeJs</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collecting cluster node metics and events through NPD"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/kubernetes/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Node Problem Detector</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">NSQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">OceanBase</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The display metrics of OpenAI include the total number of requests, response time, number of requests, number of request errors, and number of consumed tokens."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/openai/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">OpenAI</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect OpenGaussian metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opengauss/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">OpenGauss</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">OpenTelemetry Golang</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">OpenTelemetry Java</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">OpenTelemetry</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Oracle</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Guance Cloud added more OpenTelemetry plugins"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">OpenTelemetry Extensions</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="OpenTelemetry Exportor for Guance Cloud"
  				data-summary="Export OpenTelemetry data to GuanCe Cloud directly"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/opentelemetry/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">OpenTelemetry Exportor for Guance Cloud</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Exception Events and PagerDuty Linkage"
  				data-summary="When our application or system encounters exceptions, it usually needs to be dealt with promptly to ensure the normal operation of the system. To better manage and track exception events, we can send these events to PagerDuty to create events, so that we can track, analyze, and solve these problems in PagerDuty. By quickly sending exception events to PagerDuty to create events, it provides us with better capabilities to manage and track exception events, thereby better ensuring the normal operation of the system. At the same time, this method can also help us better analyze and solve problems, improving the stability and reliability of the system."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/pagerduty/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Exception Events and PagerDuty Linkage</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Obtain metrics, link tracking, and log information for PHP applications"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/php/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">PHP</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">PinPoint Golang</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">PinPoint Java</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Pinpoint</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Pipeline Offload</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">PostgreSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling C++</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling .Net</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling C++</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling Java</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling NodeJS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling PHP</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling Python</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Profiling</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Prometheus Exporter</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Prometheus Remote Write</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Promtail</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Proxy</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Prometheus Push Gateway</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Pythond</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">RabbitMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Redis Sentinel Cluster Metrics, Log Information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/redis/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Redis Sentinel</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Redis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Resin Performance metrics display, including startup time, heap memory, non heap memory, classes, threads, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/resin/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Resin</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect RocketMQ related index information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/rocketmq/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">RocketMQ</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">RUM</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect information about Seata-related metrics"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/seata/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Seata</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">SCheck</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Hardware Sensors</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">SkyWalking</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Disk S.M.A.R.T</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">SNMP</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Socket</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Solr</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">SQLServer</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">SSH</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">StatsD</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Swap</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">System</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">TDengine</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Telegraf</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cdb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud CDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance platform Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_ckafka/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud CKafka</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Tencent CLB Private"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent CLB Private</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_clb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud CLB Public</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the Guance cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cos/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud COS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the "Watch Cloud Sync" script package in the script market to synchronize the data of the cloud monitoring cloud assets to the watch cloud"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_cvm/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud CVM</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Tencent KeeWiDB"
  				data-summary="Tencent Cloud KeeWiDB metric display includes metrics such as connection count, requests, cache, keys, and slow queries."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_keewidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent KeeWiDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mariadb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud MariaDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_memcached/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud Memcached</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud MongoDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_postgresql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud PostgreSQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Tencent Redis"
  				data-summary="Tencent Cloud Redis metrics display, including connection count, request count, latency, and slow queries."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_redis_mem/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Redis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_sqlserver/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud SQLServer</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-name="Tencent Cloud TDSQL-C MySQL"
  				data-summary="Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tencent_tdsql_c_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Tencent Cloud TDSQL-C MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect TiDB cluster, TiDB, Etcd, Region and other related component metric information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/tidb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">TiDB</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Tomcat</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Tracing Propagator</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect Trino metrics information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/trino/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Trino</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">VMware</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="The display metrics of Voltage ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS, which reflect the computing, memory, network, and storage performance of ECS instances."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_ecs/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine ECS</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Volcengine MongoDB replica set metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine MongoDB Replica Set</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Volcengine MongoDB Sharded Cluster metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mongodb/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine MongoDB Sharded Cluster</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Volcengine MySQL indicators display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_mysql/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine MySQL</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
									src="..//icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine Redis</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Volcengine VKE metrics collection, including Cluster, Container, Node, Pod, etc."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/volcengine_vke/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Volcengine VKE</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Windows Event</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Zabbix Export</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="ZadigX is a cloud-native DevOps value chain platform developed by KodeRover based on Kubernetes."
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zadigx/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">Zadigx</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  						<span class="fth-integration-name">Zipkin</span>
  					</div>
  					<div class="integration-list-item-right">
  						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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
  				data-summary="Collect zookeeper related index information"
  			>
  				<div class="fth-integration-list-card">
  					<div class="integration-list-item-left">
  						<img
									src="../icon/zookeeper/icon.png"
									onerror="this.onerror = ''; this.src = '../icon/integration-default-logo.png'"
									alt=""
  						/>
  						<span class="fth-integration-name">ZooKeeper</span>
  					</div>
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
            const limitTags = ['Alibaba Cloud', 'Tencent Cloud', 'Huawei Cloud', 'GCP', 'AWS', 'AZURE', 'MIDDLEWARE', 'HOST', 'IPMI', 'KUBERNETES', 'CONTAINERS', 'NETWORK', 'EBPF', 'BPF', 'SNMP', 'PROMETHEUS', 'ZABBIX', 'TELEGRAF', 'CACHING', 'MESSAGE QUEUES', 'DATA STORES', 'LANGUAGE', 'TRACING、APM', 'PROFILE', 'LOG', 'TESTING', 'WEB', 'MOBILE', 'CI/CD', 'JENKINS', 'GITLAB', 'SESSION REPLAY'];
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
  						((!tags && !tag) || tags.includes(tag)) && (!name || name.includes(search) || summary.includes(search));
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
  						href && (window.location.href = href);
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
