from flask import Flask, request, jsonify, Response
import requests
from deep_translator import GoogleTranslator

app = Flask(__name__)

# Hàm để lấy quote từ ZenQuotes API
def get_quote_from_api():
    url = 'https://zenquotes.io/api/random'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        quote = data[0]['q'] + " - " + data[0]['a']
        return quote
    else:
        return None

# Hàm để lấy joke từ Official Joke API
def get_joke_from_api():
    url = 'https://official-joke-api.appspot.com/random_joke'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return f"{data['setup']} - {data['punchline']}"
    else:
        return None

# Hàm để dịch nội dung sang ngôn ngữ chỉ định
def translate_text(text, dest_language):
    translated = GoogleTranslator(source='auto', target=dest_language).translate(text)
    return translated

# Route chính để hiển thị hướng dẫn sử dụng
@app.route('/', methods=['GET'])
def api_index():
    return Response(
	"API Thành ngữ và dad joke Việt Nam\n"
	"\n"
	"Nguồn:\n"
	"\n"
	"Zen Qoutes (Việt hoá bởi Google Translate)\n"
	"Official Joke (Việt hoá bởi Google Translate)\n"
        "\n"
	"Available Routes (Các node API có sẵn):\n"
	"\n"
        "/api/quote\n"
        "  Method: GET\n"
        "  Description: Get a random quote from ZenQuotes and translate it to the specified language.\n"
        "  Params:\n"
        "    lang: Language to translate to (default: vi, e.g., en, fr, de).\n"
        "  Example: /api/quote?lang=en\n\n"
        "/api/joke\n"
        "  Method: GET\n"
        "  Description: Get a random joke from Official Joke API and translate it to the specified language.\n"
        "  Params:\n"
        "    lang: Language to translate to (default: vi, e.g., en, fr, de).\n"
        "  Example: /api/joke?lang=en\n",
        mimetype='text/plain',
        status=200
    )

# Định nghĩa route cho API quote
@app.route('/api/quote', methods=['GET'])
def get_quote():
    lang = request.args.get('lang', 'vi')  # Mặc định là tiếng Việt
    quote = get_quote_from_api()
    
    if quote is None:
        return jsonify({"error": "Không thể lấy dữ liệu từ API."}), 500

    translated_quote = translate_text(quote, lang)
    return jsonify({"quote": translated_quote}), 200

# Định nghĩa route cho API joke
@app.route('/api/joke', methods=['GET'])
def get_joke():
    lang = request.args.get('lang', 'vi')  # Mặc định là tiếng Việt
    joke = get_joke_from_api()
    
    if joke is None:
        return jsonify({"error": "Không thể lấy dữ liệu từ API."}), 500

    translated_joke = translate_text(joke, lang)
    return jsonify({"joke": translated_joke}), 200

if __name__ == '__main__':
    app.run(debug=True)
