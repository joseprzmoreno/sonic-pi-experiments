from google_speech import Speech
from unidecode import unidecode
from os import path
from pydub import AudioSegment

def slugize(sentence, lang):
    sentence = unidecode(sentence)
    sentence = sentence.replace(" ", "_")
    sentence = sentence.replace(".","")
    sentence = sentence.replace("?", "")
    sentence = sentence.replace("-", "_")
    sentence = sentence.lower()
    return sentence + "_" + lang    

def save_sentence(sentence, lang):
    speech = Speech(sentence, lang)
    filename = "audios/" + slugize(sentence, lang)
    if len(filename) > 50:
        filename = filename[:50]
    mp3_file = filename + ".mp3"
    wav_file = filename + ".wav"
    speech.save(mp3_file)                                                                                                                         
    sound = AudioSegment.from_mp3(mp3_file)
    sound.export(wav_file, format="wav")

save_sentence("Quizá quede algo de esperanza", "es-US")
