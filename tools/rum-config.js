window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.init({
    applicationId: 'guance_docs_centre',
    datakitOrigin: 'https://rum-report.guance.com/', // 协议（包括：//），域名（或IP地址）[和端口号]
    env: 'production',
    version: '1.0.0',
    service: 'guance-doc',
    trackInteractions: true,
    tracingSampleRate: 100,
    sessionReplaySampleRate: 80,
  })
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.startSessionReplayRecording &&
  window.DATAFLUX_RUM.startSessionReplayRecording()
