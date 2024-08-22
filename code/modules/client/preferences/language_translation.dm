#define YANDEX_API_KEY "your_yandex_api_key_here"
#define YANDEX_API_URL "https://translate.yandex.net/api/v1.5/tr.json/translate"

/datum/component/language_translator
    var/translation_mode

/datum/component/language_translator/Initialize(mode)
    translation_mode = mode
    RegisterSignal(parent, COMSIG_LIVING_TRANSLATE_MESSAGE, .proc/translate_message)

/datum/component/language_translator/proc/translate_message(datum/source, message, datum/language/message_language)
    switch(translation_mode)
        if("russian_to_english")
            return translate_russian_to_english(message)
        if("english_to_russian")
            return translate_english_to_russian(message)
        if("both")
            return translate_both_ways(message)
    return message

/proc/translate_russian_to_english(message)
    return yandex_translate(message, "ru-en")

/proc/translate_english_to_russian(message)
    return yandex_translate(message, "en-ru")

/proc/translate_both_ways(message)
    var/translated = yandex_translate(message, "ru-en")
    if(translated == message)
        translated = yandex_translate(message, "en-ru")
    return translated

/proc/yandex_translate(text, lang_pair)
    var/list/query = list(
        "key" = YANDEX_API_KEY,
        "text" = text,
        "lang" = lang_pair
    )
    var/response = world.Export("[YANDEX_API_URL]?[http_build_query(query)]")
    if(!response)
        return text

    var/result = json_decode(file2text(response["CONTENT"]))
    if(!result || !result["text"] || !length(result["text"]))
        return text

    return result["text"][1]

#undef YANDEX_API_KEY
#undef YANDEX_API_URL
