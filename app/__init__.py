from flask import Flask
from app.config import Config
from flask_wtf.csrf import CSRFProtect
import sys
import logging

csrf = CSRFProtect()

# In-memory dictionary for Pandas Dataframes
DATA_STORE = {}

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    stream=sys.stdout
)
logger = logging.getLogger(__name__)

def create_app():
    app = Flask(__name__, static_folder="../", static_url_path="")
    app.config.from_object(Config)
    app.config['MAX_CONTENT_LENGTH'] = 200 * 1024 * 1024  # 200MB max upload
    
    logger.info("Initializing Flask app...")

    csrf.init_app(app)

    # Register Blueprints
    try:
        from app.routes.api import api_bp
        from app.routes.auth import auth_bp
        from app.routes.admin import admin_bp

        app.register_blueprint(api_bp, url_prefix="/api")
        app.register_blueprint(auth_bp, url_prefix="/api/auth")
        app.register_blueprint(admin_bp, url_prefix="/api/admin")
        logger.info("Blueprints registered successfully")
    except Exception as e:
        logger.error(f"Error registering blueprints: {e}")
        raise

    @app.route("/")
    def index():
        return app.send_static_file("index.html")
    
    @app.route("/health")
    def health():
        """Simple health check endpoint"""
        return {"status": "ok"}, 200

    # Load data on startup (non-blocking, with comprehensive error handling)
    logger.info("Starting data loader...")
    with app.app_context():
        try:
            from app.services.data_loader import load_all_data
            load_all_data()
            logger.info("Data loading complete")
        except ImportError as e:
            logger.warning(f"Could not import data loader: {e}")
        except Exception as e:
            logger.warning(f"Data loading encountered issues (will continue): {e}")
            # App continues to run even if data loading fails

    logger.info("Flask app initialization complete")
    return app

