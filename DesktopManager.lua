function FindFiles()
  local files = fs.list("./")
  local resultFiles = {}
  local resultIcons = {}
  for file = 1, #files do
    if fs.isDir(files[file]) then
      local files2 = fs.list("./"..files[file])
      for file2 = 1,# files2 do
        if fs.isDir("./"..files[file].."/"..files2[file2]) then
        else
          if files2[file2] == "ICON" then
            resultIcons[#resultIcons+1] = files[file].."/"..files2[file2]
          else
            resultIcons[#resultIcons+1] = "./system/icon"
          end
          resultFiles[#resultFiles+1] = "./"..files[file].."/"..files2[file2]
        end
      end
  end
  return {resultFiles,resultIcons}
end
