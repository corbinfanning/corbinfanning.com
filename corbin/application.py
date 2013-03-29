from flask import Flask, render_template
import settings

app = Flask(__name__, static_url_path='/static',
            static_folder=settings.STATIC_DIR,
            template_folder=settings.TEMPLATE_DIR)
app.config.from_object(settings)
app.debug = True


@app.route('/')
def index():
    return render_template('index.html')


if __name__ == "__main__":
    app.run()
