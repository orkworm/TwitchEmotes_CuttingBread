local path = "Interface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes\\"

local cuttingbread_emotes = {
    ["1090sir"] = path .. "1090sir.tga:28:28",
    ["1960bread"] = path .. "1960bread.tga:28:28",
    ["3_"] = path .. "3_.tga:28:28",
    ["5head"] = path .. "5head.tga:28:28",
    ["8748_gigachad"] = path .. "8748_gigachad.tga:28:28",
    ["aa3Imgur"] = path .. "aa3Imgur.tga:28:28",
    ["aa5Imgur"] = path .. "aa5Imgur.tga:28:28",
    ["actualgoodjoblads"] = path .. "actualgoodjoblads.tga:28:14",
    ["affli"] = path .. "affli.tga:28:28",
    ["andrewohmy"] = path .. "andrewohmy.tga:28:28",
    ["andrew"] = path .. "andrew.tga:28:28",
    ["anxietyhut"] = path .. "anxietyhut.tga:28:28",
    ["baldworm"] = path .. "baldworm.tga:28:28",
    ["benched"] = path .. "benched.tga:28:28",
    ["catpoint"] = path .. "catpoint.tga:28:28",
    ["caught"] = path .. "caught.tga:28:28",
    ["charlie"] = path .. "charlie.tga:28:28",
    ["cinema"] = path .. "cinema.tga:28:28",
    ["cockge"] = path .. "cockge.tga:28:28",
    ["cringe"] = path .. "cringe.tga:28:28",
    ["cupcake"] = path .. "cupcake.tga:28:28",
    ["demo"] = path .. "demo.tga:28:28",
    ["destro"] = path .. "destro.tga:28:28",
    ["diessunday"] = path .. "diessunday.tga:28:28",
    ["drability"] = path .. "drability.tga:28:28",
    ["dumbass"] = path .. "dumbass.tga:28:28",
    ["fatgenius"] = path .. "fatgenius.tga:28:28",
    ["frost"] = path .. "frost.tga:29:61",
    ["genius"] = path .. "genius.tga:28:28",
    ["gigachad"] = path .. "gigachad.tga:28:28",
    ["goodjoblads1"] = path .. "goodjoblads~1.tga:28:28",
    ["goodjoblads2"] = path .. "goodjoblads~2.tga:28:18",
    ["goodjoblads3"] = path .. "goodjoblads~3.tga:64:41",
    ["goodjoblads4"] = path .. "goodjoblads~4.tga:28:28",
    ["goodjoblads"] = path .. "goodjoblads.tga:28:28",
    ["hard"] = path .. "hard.tga:28:28",
    ["hitler"] = path .. "hitler.tga:28:28",
    ["huh"] = path .. "huh.tga:28:28",
    ["icant"] = path .. "icant.tga:28:28",
    ["ItsCritical"] = path .. "ItsCritical.tga:28:28",
    ["jeff"] = path .. "jeff.tga:28:28",
    ["jewworm"] = path .. "jewworm.tga:28:28",
    ["kim"] = path .. "kim.tga:28:28",
    ["KMS"] = path .. "KMS.tga:28:28",
    ["KYN1Kbf"] = path .. "KYN1Kbf.tga:28:28",
    ["lightwork"] = path .. "lightwork.tga:28:28",
    ["mage83"] = path .. "mage83.tga:28:28",
    ["mage_arcane78"] = path .. "mage_arcane78.tga:28:28",
    ["mage_fire76"] = path .. "mage_fire76.tga:28:28",
    ["mage_frost27"] = path .. "mage_frost27.tga:28:28",
    ["mammamia"] = path .. "mammamia.tga:28:28",
    ["midget"] = path .. "midget.tga:28:28",
    ["mrclean"] = path .. "mrclean.tga:28:28",
    ["NATTYSUS"] = path .. "NATTYSUS.tga:28:28",
    ["nk"] = path .. "nk.tga:28:28",
    ["nonce"] = path .. "nonce.tga:28:28",
    ["normalorkworm"] = path .. "normalorkworm.tga:28:22",
    ["o7"] = path .. "o7.tga:28:28",
    ["odakap"] = path .. "odakap.tga:28:28",
    ["ohmy"] = path .. "ohmy.tga:28:28",
    ["ork07"] = path .. "ork07.tga:28:28",
    ["orkheart"] = path .. "orkheart.tga:28:28",
    ["paladin"] = path .. "paladin.tga:28:28",
    ["pepegaabove"] = path .. "pepegaabove.tga:28:28",
    ["placeholder2"] = path .. "placeholder2.tga:28:28",
    ["placeholder"] = path .. "placeholder.tga:28:28",
    ["priest"] = path .. "priest.tga:28:28",
    ["psycho"] = path .. "psycho.tga:28:28",
    ["silence"] = path .. "silence.tga:28:28",
    ["SUS"] = path .. "SUS.tga:28:28",
    ["swastika"] = path .. "swastika.tga:28:28",
    ["ta7"] = path .. "ta7.tga:28:28",
    ["tacticalgenius"] = path .. "tacticalgenius.tga:51:78",
    ["ta"] = path .. "ta.tga:28:28",
    ["taught"] = path .. "taught.tga:28:28",
    ["test2"] = path .. "test2.tga:28:21",
    ["test3"] = path .. "test3.tga:28:21",
    ["test"] = path .. "test.tga:28:21",
    ["toast"] = path .. "toast.tga:28:28",
    ["tuh"] = path .. "tuh.tga:28:28",
    ["vaism"] = path .. "vaism.tga:31:108",
    ["waterboy"] = path .. "waterboy.tga:28:28",
    ["willy"] = path .. "willy.tga:28:28",
    ["wipeit"] = path .. "wipeit.tga:28:28",
    ["wow_Death_Knight"] = path .. "wow_Death_Knight.tga:28:28",
    ["wowdh"] = path .. "wowdh.tga:28:28",
    ["wow_Druid"] = path .. "wow_Druid.tga:28:28",
    ["wow_Hunter"] = path .. "wow_Hunter.tga:28:28",
    ["wowmonk"] = path .. "wowmonk.tga:28:28",
    ["wow_Paladin"] = path .. "wow_Paladin.tga:28:28",
    ["wow_Priest"] = path .. "wow_Priest.tga:28:28",
    ["wow_Rogue"] = path .. "wow_Rogue.tga:28:28",
    ["wow_Shaman"] = path .. "wow_Shaman.tga:28:28",
    ["wow_Warlock"] = path .. "wow_Warlock.tga:28:28",
    ["wow_Warrior"] = path .. "wow_Warrior.tga:28:28",
    ["youngthug"] = path .. "youngthug.tga:28:28",
    ["yuh"] = path .. "yuh.tga:42:64",
}

function cuttingbread_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function cuttingbread_table_concat(t1, t2)
    t3 = {}
    for key, value in pairs(t1) do
        t3[key] = value
    end
    for key, value in pairs(t2) do
        t3[key] = value
    end
    return t3
end

function cuttingbread_suggestion_reloader(suggestions)
    if (judhead_initsuggestions == nil) then
        local combined = cuttingbread_table_concat(AllTwitchEmoteNames, suggestions)
        for _, frameName in pairs(CHAT_FRAMES) do
            local frame = _G[frameName]

            local editbox = frame.editBox;
            local suggestionList = combined;
            local maxButtonCount = 20;

            local autocompletesettings = {
                perWord = true,
                activationChar = ':',
                closingChar = ':',
                minChars = 2,
                fuzzyMatch = true,
                onSuggestionApplied = function(suggestion)
                    UpdateEmoteStats(suggestion, true, false, false);
                end,
                renderSuggestionFN = Emoticons_RenderSuggestionFN,
                suggestionBiasFN = function(suggestion, text)
                    if TwitchEmoteStatistics[suggestion] ~= nil then
                        return TwitchEmoteStatistics[suggestion][1] * 5
                    end
                    return 0;
                end,
                interceptOnEnterPressed = true,
                addSpace = true,
                useTabToConfirm = Emoticons_Settings["AUTOCOMPLETE_CONFIRM_WITH_TAB"],
                useArrowButtons = true,
            }

            SetupAutoComplete(editbox, suggestionList, maxButtonCount, autocompletesettings);
        end
    else
        local i = cuttingbread_table_length(suggestions)
        for name, path in pairs(judhead_emotes) do
            suggestions[i] = name
            i = i + 1
        end
        judhead_initsuggestions(suggestions)
    end
end

local function cuttingbread_main() 

    local dropdown = { "cuttingbread" }
    local i = 1
    local suggestions = {}
    for name, path in pairs(cuttingbread_emotes) do
        table.insert(dropdown, name)
        TwitchEmotes:AddEmote(name, name, path)
        suggestions[i] = name
        i = i + 1
    end

    table.insert(TwitchEmotes_dropdown_options, dropdown)

    cuttingbread_suggestion_reloader(suggestions)
end

cuttingbread_main()
