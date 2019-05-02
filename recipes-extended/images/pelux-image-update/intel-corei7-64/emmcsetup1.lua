function os.capture(cmd)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	return s
end

function cmdexec(cmd)
	local ret, s, status = os.execute(cmd)
	if (status ~= 0) then
		return false, cmd .. " return with error " .. status
	end

	return true,""
end

function get_device_from_boot_device_label(label)
	local pdev
	local dev

	pdev = os.capture("lsblk -no PARTLABEL,PKNAME | grep " .. label .. " | awk '{print $2}'")

	dev = os.capture("lsblk -no PARTLABEL,KNAME | grep " .. label .. " | awk '{print $2}'")

	return pdev, dev
end

function get_update_device_from_boot_device(dev)
	local part = ""
	local length = dev:len()-1
	local num = dev:sub(length, length)

	if ("2" == num) then
		part = "3"
	elseif ("3" == num) then
		part = "2"
	else
		return false, "Incorrect Partition number " .. num
	end

	local updatedev = dev:sub(1, length-1) .. part

	return true, updatedev
end

function get_update_device_from_boot_device_label(label)
	local ret
	local pdev
	local bootdev
	local updatedev

	pdev, bootdev = get_device_from_boot_device_label(label)

	ret, updatedev = get_update_device_from_boot_device(bootdev)

	print("Boot Device:", bootdev, "Update Device:", updatedev)

	return ret, updatedev
end

function preinst()
	local out = "Pre installed script called"
	local ret
	local updatedev

	ret, updatedev = get_update_device_from_boot_device_label("platform2")
	if (ret == false) then
		return ret, updatedev .. ", Cannot find update device"
	end

	ret, out = cmdexec("ln -s /dev/" .. updatedev .. " /dev/updatedev")
	if (false == ret) then
		return ret, out
	end

	return ret, out
end

function postinst()
	local out = "Post installed script called"
	local ret
	local updatedev

	ret, updatedev = get_update_device_from_boot_device_label("platform2")
	if (ret == false) then
		return ret, updatedev .. ", Cannot find update device"
	end

	local mountpoint = "/tmp/mounted" .. updatedev
	local mountdev = "/dev/" .. updatedev
	local servicepath = mountpoint .. "/lib/systemd/system/swupdate.service"

	ret, out = cmdexec("mkdir -p " .. mountpoint)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("mount " .. mountdev .. " " .. mountpoint)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("sed -i -e 's/main/alt/' " .. servicepath)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("sed -i -e 's/-c [0-3]/-c 2/' " .. servicepath)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("umount " .. mountpoint)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("rm -rf " .. mountpoint)
	if (false == ret) then
		return ret, out
	end

	ret, out = cmdexec("rm /dev/updatedev")
	if (false == ret) then
		return ret, out
	end

	return true, out
end
