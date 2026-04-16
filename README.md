# OCR Tool - PDF Processor

A modern web application that transforms scanned PDFs into searchable documents and editable Word files using OCR technology.

## Features

- **Drag & Drop Upload**: Easy file uploading with drag-and-drop support
- **OCR Processing**: Uses ocrmypdf to make PDFs fully searchable with a text layer
- **Auto Deskew**: Automatically straightens crooked pages for better OCR results
- **PDF to Word Conversion**: Convert processed PDFs to editable .docx documents
- **Progress Indication**: Real-time feedback during processing
- **Responsive Design**: Works on desktop and mobile devices with Tailwind CSS

## Requirements

- Python 3.8+
- Flask 3.0.0+
- ocrmypdf 16.0.0+
- pdf2docx 0.5.1+
- Tesseract OCR (required by ocrmypdf)

## Installation

### Step 1: Install Python Dependencies

```bash
pip install -r requirements.txt
```

### Step 2: Install Tesseract OCR

#### Windows:
1. Download the installer from: https://github.com/UB-Mannheim/tesseract/wiki
2. Run the installer and follow the installation wizard
3. The default installation path is `C:\Program Files\Tesseract-OCR`

#### macOS:
```bash
brew install tesseract
```

#### Linux (Ubuntu/Debian):
```bash
sudo apt-get install tesseract-ocr
```

### Step 3: Configure Tesseract Path (Windows only)

If you installed Tesseract in a non-default location, update `app.py`:

```python
import pytesseract
pytesseract.pytesseract.pytesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
```

## Usage

### Running the Application

```bash
python app.py
```

The application will be available at: http://localhost:5000

### Using the OCR Tool

1. Open the application in your web browser
2. Drag and drop a PDF file into the upload zone (or click to browse)
3. Click "Upload & Process"
4. Wait for the OCR processing to complete
5. Download your:
   - **Searchable PDF**: PDF with text layer added
   - **Editable Word Doc**: Converted to Microsoft Word format (.docx)

## Project Structure

```
ocr-tool/
├── app.py              # Flask application and API endpoints
├── requirements.txt    # Python dependencies
├── templates/
│   └── index.html      # Frontend HTML template
├── static/             # Static files (CSS, JS)
├── uploads/            # Temporary uploaded files
└── processed/          # Processed output files
```

## API Endpoints

### POST `/upload`
Upload and process a PDF file

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body: file (PDF file)

**Response (JSON):**
```json
{
  "success": true,
  "file_id": "unique-id",
  "message": "File processed successfully",
  "pdf_ready": true,
  "docx_ready": true
}
```

### GET `/download/<file_id>/<file_type>`
Download processed file

**Parameters:**
- `file_id`: Unique file identifier from upload response
- `file_type`: Either "pdf" or "docx"

**Response:** File download

### GET `/`
Render main application page

## Configuration

### Maximum File Size
Default: 50 MB

To change, edit in `app.py`:
```python
MAX_FILE_SIZE = 50 * 1024 * 1024  # Change this value
```

### OCR Language
Default: English ("eng")

To add more languages, modify in `app.py`:
```python
ocrmypdf.ocr(
    original_path,
    searchable_pdf_path,
    deskew=True,
    language='eng+fra+deu',  # English, French, German
    progress_bar=False
)
```

Available language codes: https://github.com/UB-Mannheim/tesseract/wiki/Downloads-for-every-Tesseract-User-(International)

## Error Handling

The application includes comprehensive error handling for:
- Invalid file types
- File size exceeding limits
- OCR processing failures
- Word conversion failures
- Missing files during download

## Frontend Features

- **Modern UI**: Built with Tailwind CSS
- **Drag & Drop**: Intuitive file upload
- **Progress Animation**: Visual feedback during processing
- **Responsive Design**: Mobile-friendly interface
- **Error Messages**: Clear feedback for user actions
- **File Validation**: Client and server-side validation

## Troubleshooting

### Tesseract not found
```
FileNotFoundError: [Errno 2] No such file or directory: 'tesseract'
```

**Solution:** Install Tesseract OCR or set the path in `app.py`

### PDF conversion to docx fails
Some complex PDFs may not convert properly. The application handles this gracefully by allowing PDF download even if docx conversion fails.

### Memory issues with large files
If you encounter memory issues:
1. Reduce `MAX_FILE_SIZE` in `app.py`
2. Process files one at a time
3. Close background applications

## Performance Tips

- **OCR Speed**: Processing time depends on:
  - PDF page count
  - Image resolution
  - System CPU/RAM
- **Typical Processing**: 1-3 minutes for a standard 10-page document
- **Server Requirements**:
  - Minimum: 2GB RAM
  - Recommended: 4GB+ RAM for concurrent processing

## Supported Formats

**Input:** PDF files (scanned or image-based)

**Output:**
- Searchable PDF (PDF with text layer)
- Microsoft Word Document (.docx)

## License

This project is provided as-is for personal and commercial use.

## Support

For issues or questions:
1. Check the Troubleshooting section
2. Verify Tesseract OCR is properly installed
3. Check application logs for error details

---

**Note:** The first OCR run may take longer as Tesseract initializes. Subsequent runs will be faster.
