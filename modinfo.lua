name = "Abigail Flower Sanity Station Again"
description = "Turn the Abigail Flower into Flower or even Evil Flower."
forumthread = ""
author = "辣椒小皇纸"
version = "1.1.0"
api_version = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

----------------------
-- General settings --
----------------------

configuration_options =
{
    {
        name = "daystoturn",
        label = "Days to Trun",
        hover = "Days to trun to flower or evil flower\n变成花或者恶魔花的时间",
        options =   {
                        {description = "1", data = 1, hover = ""},
                        {description = "2", data = 2, hover = ""},
                        {description = "3", data = 3, hover = ""},
                        {description = "4", data = 4, hover = ""},
                        {description = "5", data = 5, hover = ""},
                    },
        default = 3,
    },
    {
        name = "turntowhich",
        label = "Which to Turn",
        hover = "Turn to flower or the evil one\n变成花还是恶魔花",
        options =   {
                        {description = "Flower 普通的花", data = "flower", hover = ""},
                        {description = "Evil Flower 恶魔花", data = "flower_evil", hover = ""},
                    },
        default = "flower",
    }
    {
        name = "evilflowerprotection",
        label = "Evil Flower Protection",
        hover = "Evil Flower become fireproof and can't be picked but can be removed by shovel with 3 times of digging\n恶魔花防火，不能被采，可以用铲子铲3下去除",
        options =   {
                        {description = "Yes", data = true, hover = ""},
                        {description = "No", data = false, hover = ""},
                    },
        default = false,
    }
}