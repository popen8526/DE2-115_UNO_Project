# !/usr/bin/env python
from serial import Serial, EIGHTBITS, PARITY_NONE, STOPBITS_ONE
import speech_recognition as sr
from sys import argv
import time

assert len(argv) == 2

s = Serial(
    port=argv[1],
    baudrate=115200,
    bytesize=EIGHTBITS,
    parity=PARITY_NONE,
    stopbits=STOPBITS_ONE,
    xonxoff=False,
    rtscts=False
)

time.sleep(2)

keywords = ["左", "右", "enter", "空白鍵", "重開", "UNO"]
keyword_types = {
    "左": [1,1,1,1,1,1,1,1], # q
    "右": [2,2,2,2,2,2,2,2], # e
    "enter": [3,3,3,3,3,3,3,3], # enter
    "空白鍵": [4,4,4,4,4,4,4,4], # space
    "重開": [5,5,5,5,5,5,5,5], # r 
    "UNO": [6,6,6,6,6,6,6,6] # u
}

def recognize_speech_from_mic(recognizer, microphone):
    if not isinstance(recognizer, sr.Recognizer):
        raise TypeError("`recognizer` must be `speech_recognition.Recognizer` instance")
    if not isinstance(microphone, sr.Microphone):
        raise TypeError("`microphone` must be `speech_recognition.Microphone` instance")

    with microphone as source:
        recognizer.adjust_for_ambient_noise(source)
        print("請開始說話...")
        audio = recognizer.listen(source)

    response = {
        "success": True,
        "error": None,
        "transcription": None
    }

    try:
        response["transcription"] = recognizer.recognize_google(audio, language='zh-TW')
    except sr.RequestError:
        response["success"] = False
        response["error"] = "API 不可用"
    except sr.UnknownValueError:
        response["error"] = "無法識別聲音"

    return response

def main():
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()
    prev = [0,0,0,0,0,0,0,0]
    while True:
        result = recognize_speech_from_mic(recognizer, microphone)
        
        if result["transcription"]:
            print("你說了:", result["transcription"])
            for keyword in keywords:
                if keyword in result["transcription"]:
                    keyword_type = keyword_types[keyword]
                    print(f"檢測到keyword: {keyword}, type: {keyword_types[keyword]}")
                    s.write(keyword_types[keyword])
                    prev = keyword_types[keyword]
                    break
                else :
                    s.write([0,0,0,0,0,0,0,0])
                    # s.write(prev)
        if not result["success"]:
            s.write([0,0,0,0,0,0,0,0])
            # s.write(prev)
            break
        if result["error"]:
            s.write([0,0,0,0,0,0,0,0])
            # s.write(prev)
            print("error:", result["error"])

if __name__ == "__main__":
    main()