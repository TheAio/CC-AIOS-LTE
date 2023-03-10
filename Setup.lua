Version = "f94ea0c"
function Reset()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.yellow)
    print("AIOS-LTE OOTB")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end
Reset()
print("Wellcome to AIOS-LTE Out Of The Box Setup!")
textutils.slowPrint("This section is only avaible in english")
--This part is for displaying the license
print("Please make sure that you have read the license for CC-AIOS-LTE")
print("It can be found here:")
print("https://raw.githubusercontent.com/TheAio/CC-AIOS-LTE/main/LICENSE")
textutils.slowPrint("Press 'Y' if you agree to the license otherwise press 'N' if you do not agree")
while true do
    E,K = os.pullEvent("key")
    if K == keys.y then
        break
    elseif K == keys.n then
        printError("license was rejected")
        return false
    end
end
Reset()
--This part is for selecting a language
textutils.slowPrint("Thank you! A great system is just afew steps away...")
print("Please wait...")
shell.run("mkdir localization")
shell.run("wget https://raw.githubusercontent.com/TheAio/CC-AIOS-LTE/main/Languagelist.txt")
shell.run("mv Languagelist.txt localization/LanguageList.txt")
if fs.exists("localization/LanguageList.txt") then
    print("Almost ready...")
    LanguageListFile = fs.open("localization/LanguageList.txt","r")
else
    printError("localization/LanguageList.txt could not be found!")
    printError("please make sure that you (and if emulated your computer) can reach the internet")
    printError("If you belive this is an error please report it with the error code:")
    error("Unable to read localization/LanguageList.txt")
end
Languages = {}
while true do
    local temp = LanguageListFile.readLine()
    if temp == nil then
        LanguageListFile.close()
        break
    else
        Languages[#Languages+1] = temp
    end
end
if #Languages > 0 then
    while true do
        Reset()
        print("Please select a language:")
        for i=1,#Languages do
            print(i,Languages[i])
            sleep(0)
        end
        print("Enter a number between 1 and",#Languages)
        local sel = tonumber(read())
        if sel == nil then
            print("Please enter a whole number without any decimals!")
            sleep(2)
        elseif sel < 1 then
            print("Please select a number that is higher then 0")
        elseif sel > #Languages then
            print("Please select a number that is lower then",#Languages)
        else
            Reset()
            print("#----")
            term.setTextColor(colors.gray)
            shell.run("wget https://raw.githubusercontent.com/TheAio/CC-AIOS-LTE/main/languageDownloads.txt")
            shell.run("mkdir temp")
            shell.run("mv languageDownloads.txt temp/languageDownloads.txt")
            if fs.exists("temp/languageDownloads.txt") then
                Reset()
                print("##---")
            else
                printError("Failed to find temp/languageDownloads.txt")
                printError("If this error keeps ocurring please report it with the error code:")
                error("Failed to find or download languageDownloads.txt")
            end
            local file = fs.open("temp/languageDownloads.txt","r")
            LanguageDownloadsList = {}
            while true do
                local temp2 = file.readLine()
                if temp2 == nil then
                    break
                else
                    LanguageDownloadsList[#LanguageDownloadsList+1] = temp2
                end
            end
            file.close()
            if #LanguageDownloadsList == #Languages then
                Reset()
                print("###--")
                term.setTextColor(colors.gray)
                shell.run("cd localization")
                shell.run("mkdir languages")
                shell.run("cd languages")
                shell.run(LanguageDownloadsList[sel])
                shell.run("cd ..")
                shell.run("cd ..")
                Reset()
                print("####-")
                local LangFiles = fs.list("./localization/languages")
                local LangFile = fs.open("./localization/languages/"..LangFiles[1],"r")
                LangFileLines = {}
                while true do
                    sleep(0)
                    local temp3 = LangFile.readLine()
                    if temp3 == nil then
                        break
                    end
                    LangFileLines[#LangFileLines+1] = temp3
                end
                Reset()
                print("#####")
                LangFile.close()
                shell.run("deleate temp/")
                sleep(1)
                Reset()
                function FindTranslation(LangFileLines,keyword)
                   for Line = 1, #LangFileLines do
                        if LangFileLines[Line] == keyword then
                            return LangFileLines[Line+1]
                        end
                   end
                   return "ERROR"
                end
                print(FindTranslation(LangFileLines,"*wellcome*"),FindTranslation(LangFileLines,"*to*"),"AIOS-LTE OOTB V"..Version)
                print(FindTranslation(LangFileLines,"*please*"),FindTranslation(LangFileLines,"*select*"),FindTranslation(LangFileLines,"*a*"),FindTranslation(LangFileLines,"*timezone*"))
                print("GMT + [+]",FindTranslation(LangFileLines,"*or*"),"GMT -","["..FindTranslation(LangFileLines,"*other*").."]")
                if read() == "+" then
                    Reset()
                    print(FindTranslation(LangFileLines,"*wait*"))
                    local file2 = fs.open("localization/timezoneType","w")
                    file2.writeLine("+")
                    sleep(1)
                    file2.close()
                else
                    Reset()
                    print(FindTranslation(LangFileLines,"*wait*"))
                    local file2 = fs.open("localization/timezoneType","w")
                    file2.writeLine("-")
                    sleep(1)
                    file2.close()
                end
                Reset()
                print(FindTranslation(LangFileLines,"*please*"),FindTranslation(LangFileLines,"*enter*"),FindTranslation(LangFileLines,"*timezone*"),FindTranslation(LangFileLines,"*ammount*"),FindTranslation(LangFileLines,"*use*"),FindTranslation(LangFileLines,"*numbers*"),"[0-12]")
                while true do
                    Sel = tonumber(read())
                    if Sel == nil then
                        print(FindTranslation(LangFileLines,"*half*"),FindTranslation(LangFileLines,"*numbers*"),FindTranslation(LangFileLines,"*are*"),FindTranslation(LangFileLines,"*unsupported*"))
                    else
                        break
                    end
                end
                print(FindTranslation(LangFileLines,"*wait*"))
                local file3 = fs.open("localization/timezoneAmmount","w")
                file3.writeLine(sel)
                sleep(1)
                file3.close()
                Reset()
                print(FindTranslation(LangFileLines,"*enter*"),FindTranslation(LangFileLines,"*a*"),FindTranslation(LangFileLines,"*username*"))
                local file4 = fs.open("localization/username","w")
                file4.writeLine(read())
                Reset()
                print(FindTranslation(LangFileLines,"*wait*"))
                sleep(1)
                file4.close()
                Reset()
                print(FindTranslation(LangFileLines,"*install*"),FindTranslation(LangFileLines,"*more*"),FindTranslation(LangFileLines,"*tools*"),"[Y/n]")
                term.setBackgroundColor(colors.yellow)
                print(FindTranslation(LangFileLines,"*warning*"),FindTranslation(LangFileLines,"*some*"),FindTranslation(LangFileLines,"*tools*"),FindTranslation(LangFileLines,"*are*"),FindTranslation(LangFileLines,"*legacy*"),FindTranslation(LangFileLines,"*tools*"))
                if string.upper(read()) == "Y" then
                    if term.isColor() then
                        Reset()
                        print(FindTranslation(LangFileLines,"*wait*"))
                        local file5 = fs.open("TEMPORARY-PRINT-FILE","w")
                        file5.writeLine("print('"..FindTranslation(LangFileLines,"*installing*").."')")
                        file5.writeLine("while true do")
                        file5.writeLine("   print('>')")
                        file5.writeLine("   a = read()")
                        file5.writeLine("   if a == 'exit' then")
                        file5.writeLine("       break")
                        file5.writeLine("   else")
                        file5.writeLine("       shell.run(a)")
                        file5.writeLine("   end")
                        file5.writeLine("end")
                        sleep(1)
                        file5.close()
                        Reset()
                        shell.run("fg TEMPORARY-PRINT-FILE")
                    end
                    Reset()
                    print("#---")
                    shell.run("wget","https://raw.githubusercontent.com/TheAio/CC-ALLUDE/main/APM")
                    Reset()
                    print("##--")
                    shell.run("wget","https://raw.githubusercontent.com/TheAio/CC-ALLUDE/main/APMs")
                    Reset()
                    print("###-")
                    shell.run("wget","https://raw.githubusercontent.com/TheAio/CC-AIOS-LTE/main/InstallEverything.APMs")
                    sleep(1)
                    Reset()
                    print("####")
                    shell.run("APMs InstallEverything.APMs")
                    sleep(1)
                    shell.run("delete InstallEverything.APMs")
                    Reset()
                    if term.isColor() then
                        multishell.setFocus(1)
                    end
                end
                Reset()
                shell.run("rm TEMPORARY-PRINT-FILE")
                shell.run("rm startup")
                shell.run("wget https://raw.githubusercontent.com/TheAio/CC-AIOS-LTE/main/DesktopManager.lua startup")
                shell.run("mkdir system")
                shell.run("mkdir system/temp")
                sleep(1)
                os.reboot()
            else
                printError("A strange error ocurred or you are useing a unsupported version of AIOS-LTE")
                printError("you can find the latest official release on https://github.com/TheAio/CC-AIOS-LTE")
                printError("If you are useing the latest version and this error occurs anyway, please report it with the error code:")
                error("The list 'LanguageDownloadsList' and the list 'Languages' have diffrent lengths")
            end
        end
    end
else
    printError("A strange error ocurred or you are useing a unsupported version of AIOS-LTE")
    printError("you can find the latest official release on https://github.com/TheAio/CC-AIOS-LTE")
    printError("If you are useing the latest version and this error occurs anyway, please report it with the error code:")
    error("localization/LanguageList.txt was found but is empty or the Languages list failed to populate")
end
