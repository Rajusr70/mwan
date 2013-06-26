-- ------ extra functions ------ --

function leadtrailtrim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- ------ rc.local configuration ------ --

local rcfile = "/etc/rc.local"

m = SimpleForm("rclocal", nil)
	m:append(Template("mwan3/mwan3_adv_startup"))


f = m:section(SimpleSection, nil,
	translate("<br />This section allows you to modify the contents of /etc/rc.local<br />" ..
	"Shell commands in this file execute once system init finishes<br /><br />" ..
	"Notes:<br />" ..
	"The last line of the script must be &#34;exit 0&#34; without quotes<br />" ..
	"Put your shell commands before the &#34;exit 0&#34; line<br />" ..
	"Lines beginning with # are comments and are not executed<br /><br />"))

t = f:option(TextValue, "lines")
	t.rmempty = true
	t.rows = 20

	function t.cfgvalue()
		return nixio.fs.readfile(rcfile) or ""
	end

	function t.write(self, section, data)
		return nixio.fs.writefile(rcfile, leadtrailtrim(data:gsub("\r\n", "\n")) .. "\n")
	end

	function f.handle(self, state, data)
		return true
	end


return m
