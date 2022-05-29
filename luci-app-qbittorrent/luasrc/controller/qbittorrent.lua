module("luci.controller.qbittorrent",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/qbittorrent") then
		return
	end
	
	entry({"admin", "services", "qBittorrent"}, alias("admin", "services", "qBittorrent", "basic"), _("qBittorrent"), 30).dependent = true
	entry({"admin", "services", "qBittorrent", "basic"}, cbi("qbittorrent/basic"), _("Basic Settings"), 1).leaf = true
	entry({"admin", "services", "qBittorrent", "connection"}, cbi("qbittorrent/connection"), _("Connection Settings"), 2).leaf = true
	entry({"admin", "services", "qBittorrent", "downloads"}, cbi("qbittorrent/downloads"), _("Download Settings"), 3).leaf = true
	entry({"admin", "services", "qBittorrent", "bittorrent"}, cbi("qbittorrent/bittorrent"), _("Bittorrent Settings"), 4).leaf = true
	entry({"admin", "services", "qBittorrent", "webgui"}, cbi("qbittorrent/webgui"), _("WebUI Settings"), 5).leaf = true
	entry({"admin", "services", "qBittorrent", "advanced"}, cbi("qbittorrent/advanced"), _("Advance Settings"), 6).leaf = true
	entry({"admin", "services", "qBittorrent", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = luci.sys.call("pgrep qbittorrent-nox >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
