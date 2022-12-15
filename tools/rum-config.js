window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'guance_docs_centre',
      datakitOrigin: 'https://console.guance.com/', // 协议（包括：//），域名（或IP地址）[和端口号]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
    })