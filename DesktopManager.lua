items = {}
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
function Draw(items) --Draws items to the screen in order
    for item = 1, #items do
      for i = 1, #items[item] do
        if i == 3 then
          for j = 1, #items[item][i] do
            print(items[item][i][j])
          end
        elseif i == 2 then
          term.setBackgroundColor(items[item][i])
        else
          term.setColor(items[item][i])
        end
      end
    end
end
function Reorder(items,selection) --Pushes the selected item to the back of the list (renders ontop of everything)
    local temp = items[selection]
    for i = 1, #items do
      if #items > i+1 then
        itmes[i] = items[i+1]
      else
        items[#items+1] = temp
      end
    end
end
function LaunchScript(path) --This handles classic script
    if term.isColor() then
      shell.run("fg",path)
    else
      term.setBackgroundColor(colors.black)
      term.setColor(colors.white)
      print("Exit the program to return to desktop")
      shell.run(path)
      print("Program finished execution, press any key to return to desktop")
      os.pullEvent("keys")
    end
end
function LaunchProgram(path) --This handles advanced text files
    if fs.isDir(path) then
      if fs.exists(path.."/AP") then
        local temp = fs.open(path.."/AP","r")
        local a = temp.readLine()
        local b = temp.readLine()
        temp.close()
        local temp = fs.open(path.."/LAUNCH","r")
        local c = {}
        local d = ""
        while true do
          local d = temp.readLine()
          if d == nil then
            break
          else
            c[#c+1] = d
          end
        end
        items[#items+1] = {a,b,c}
        temp.close()
      else
        local temp = fs.open(path.."/LAUNCH","r")
        local c = {}
        local d = ""
        while true do
          local d = temp.readLine()
          if d == nil then
            break
          else
            c[#c+1] = d
          end
        end
        items[#items+1] = {colors.white,colors.black,c}
        temp.close()
      end
    else
      local temp = fs.open(path,"r")
      local c = {}
      local d = ""
      while true do
        local d = temp.readLine()
        if d == nil then
          break
        else
          c[#c+1] = d
        end
      end
      items[#items+1] = {colors.white,colors.black,c}
      temp.close()
    end
end
function FindTranslation(keyword)
    local a = fs.list("./localization/languages/")
    local file = fs.open("./localization/languages/"..a[1])
    local b = ""
    LangFileLines = {}
    while true do
      local b = file.readLine()
      if b == nil then
        break
      else
        LangFileLines[#LangFileLines+1] = b
      end
    end
    file.close()
    for Line = 1, #LangFileLines do
      if LangFileLines[Line] == keyword then
        return LangFileLines[Line+1]
      end
    end
    return "ERROR"
end
while true do
    if fs.exists("./system/AUTORUN") then
      LaunchScript("./system/AUTORUN")
    end
    local temp = fs.open("./system/temp/files","w")
    local temp2 = fs.list("./")
    for i = 1, #temp2 do
      if fs.isDir(temp2[i]) then
      else
        temp.write("./"..temp2[i])
      end
    end
    temp2.close()
    LaunchProgram("./system/temp/files")
    Draw(items)
    if #items < 2 then
      local temp,temp2 = term.getCursorPos()
      print(">")
      term.setCursorPos(temp+2,temp2)
      local sel = read()
      if fs.exists(sel) then
        Launch(sel)
      elseif sel == "exit" then
        if term.isColor() then
          printError(FindTranslation("*warning*"),FindTranslation("*there*"),FindTranslation("*exists*"),FindTranslation("*open*"),FindTranslation("*files*"))
          printError(FindTranslation("*shutdown*").."? [Y/n]")
          if string.upper(read()) == "Y" then
            term.setBackgroundColor(colors.black)
            term.clear()
          end
        else
          term.setBackgroundColor(colors.black)
          term.clear()
        end
      end
    end
end
