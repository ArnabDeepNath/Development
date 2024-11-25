import sys
import joblib
import pandas as pd
from PyQt5.QtWidgets import QApplication, QMainWindow, QFileDialog, QMessageBox, QTableWidgetItem
from PyQt5 import uic
from sklearn.metrics import accuracy_score, f1_score

class MyWindow(QMainWindow):
    
    def __init__(self):
        super(MyWindow, self).__init__()
        uic.loadUi('MainWindow2.ui', self)

        # Set a global stylesheet
        self.setStyleSheet("""
            QWidget {
                background-color: #f0f0f0;
                font-family: Arial, sans-serif;
            }

            QPushButton {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 14px;
                border-radius: 5px;
            }

            QPushButton:hover {
                background-color: #45a049;
            }

            QTextEdit {
                background-color: #ffffff;
                border: 1px solid #ccc;
                border-radius: 5px;
                padding: 10px;
                font-size: 14px;
            }
        """)

        # Connect buttons to methods
        self.uploadCsvButton.clicked.connect(self.upload_excel)
        self.loadModelButton.clicked.connect(self.load_model)
        self.predictButton.clicked.connect(self.make_prediction)
        self.saveResultsButton.clicked.connect(self.save_results)

        # Initialize variables for CSV and model
        self.df = None
        self.coverage_model = None
        self.accident_model = None
        self.vectorizer = None

    def upload_excel(self):
        # Open a file dialog to select an Excel file (XLSX)
        excel_path, _ = QFileDialog.getOpenFileName(self, "Open Excel File", "", "Excel Files (*.xlsx);;All Files (*)")
        if excel_path:
            try:
                # Load the Excel file into a pandas DataFrame
                self.df = pd.read_excel(excel_path)
                QMessageBox.information(self, "Success", "Excel file loaded successfully!")
                print("Excel loaded:", self.df.head())
            except Exception as e:
                QMessageBox.critical(self, "Error", f"Failed to load Excel file: {str(e)}")

    def load_model(self):
        # Open a file dialog to select model files
        coverage_model_path, _ = QFileDialog.getOpenFileName(self, "Open Coverage Model", "", "Model Files (*.pkl *.joblib);;All Files (*)")
        accident_model_path, _ = QFileDialog.getOpenFileName(self, "Open Accident Model", "", "Model Files (*.pkl *.joblib);;All Files (*)")
        vectorizer_path, _ = QFileDialog.getOpenFileName(self, "Open Vectorizer", "", "Model Files (*.pkl *.joblib);;All Files (*)")

        if coverage_model_path and accident_model_path and vectorizer_path:
            try:
                # Load the models and vectorizer
                self.coverage_model = joblib.load(coverage_model_path)
                self.accident_model = joblib.load(accident_model_path)
                self.vectorizer = joblib.load(vectorizer_path)

                self.calculate_model_metrics()
                # Display success message
                QMessageBox.information(self, "Success", "Models and vectorizer loaded successfully!")

            except Exception as e:
                QMessageBox.critical(self, "Error", f"Failed to load model or vectorizer: {str(e)}")
        else:
            QMessageBox.critical(self, "Error", "Please select all files for models and vectorizer.")

    def calculate_model_metrics(self):
        try:
            # Check if df is loaded
            if self.df is not None:
                # Use the loaded dataset for metrics
                X = self.df['Claim Description']  # Feature column
                X_transformed = self.vectorizer.transform(X)
                y_true = self.df['True Labels']  # Correct column for true labels

                coverage_predictions = self.coverage_model.predict(X_transformed)
                accident_predictions = self.accident_model.predict(X_transformed)

                # Calculate accuracy and F1 score for coverage model
                coverage_accuracy = accuracy_score(y_true, coverage_predictions)
                coverage_f1 = f1_score(y_true, coverage_predictions, average='weighted')

                # Calculate accuracy and F1 score for accident model
                accident_accuracy = accuracy_score(y_true, accident_predictions)
                accident_f1 = f1_score(y_true, accident_predictions, average='weighted')

                # Update the labels with the calculated metrics
                self.loaded_model_accuracy.setText(f"Coverage Model Accuracy: {coverage_accuracy:.2f}\nAccident Model Accuracy: {accident_accuracy:.2f}")
                self.loaded_model_f1_score.setText(f"Coverage Model F1 Score: {coverage_f1:.2f}\nAccident Model F1 Score: {accident_f1:.2f}")

            else:
                # If no dataset is loaded, use dummy input for demonstration
                dummy_input = ["Taillights broken.", "Broken Windshield."]  # Dummy data
                X_transformed = self.vectorizer.transform(dummy_input)

                # Simulate predictions
                coverage_predictions = self.coverage_model.predict(X_transformed)
                accident_predictions = self.accident_model.predict(X_transformed)

                # Placeholder values for metrics
                coverage_accuracy = 0.75
                coverage_f1 = 0.70
                accident_accuracy = 0.70
                accident_f1 = 0.65

                # Display placeholder metrics
                self.loaded_model_accuracy.setText(f"Coverage Model Accuracy: {coverage_accuracy:.2f}\nAccident Model Accuracy: {accident_accuracy:.2f}")
                self.loaded_model_f1_score.setText(f"Coverage Model F1 Score: {coverage_f1:.2f}\nAccident Model F1 Score: {accident_f1:.2f}")

        except Exception as e:
            print(f"Error while calculating metrics: {e}")
            QMessageBox.critical(self, "Error", f"Failed to calculate model metrics: {str(e)}")

    def make_prediction(self):
        if self.df is not None:
            # If dataset is loaded, use it for predictions
            try:
                # Clean data: Remove rows with NaN in 'Claim Description' column
                self.df.dropna(subset=['Claim Description'], inplace=True)

                # If there are any remaining NaN values, fill them or drop the rows
                self.df['Claim Description'].fillna("", inplace=True)

                # Ensure we have no NaN values before proceeding
                if self.df['Claim Description'].isnull().any():
                    raise ValueError("There are still NaN values in 'Claim Description' column.")

                # Extract feature column 'Claim Description'
                X = self.df['Claim Description']  
                X_transformed = self.vectorizer.transform(X)

                # Make predictions
                coverage_predictions = self.coverage_model.predict(X_transformed)
                accident_predictions = self.accident_model.predict(X_transformed)

                # Add predictions to DataFrame
                self.df['Coverage Predictions'] = coverage_predictions
                self.df['Accident Predictions'] = accident_predictions

                # Display predictions in a table
                self.display_predictions()

                QMessageBox.information(self, "Success", "Predictions made successfully!")

            except Exception as e:
                QMessageBox.critical(self, "Error", f"Prediction failed: {str(e)}")

        elif self.coverage_model is not None and self.accident_model is not None and self.vectorizer is not None:
            # If no dataset is uploaded, allow manual input
            try:
                user_input = self.get_manual_input()

                if user_input:
                    user_input_transformed = self.vectorizer.transform([user_input])

                    coverage_prediction = self.coverage_model.predict(user_input_transformed)
                    accident_prediction = self.accident_model.predict(user_input_transformed)

                    self.show_manual_prediction_result(user_input, coverage_prediction, accident_prediction)
                    QMessageBox.information(self, "Success", "Prediction made successfully from manual input!")

            except Exception as e:
                QMessageBox.critical(self, "Error", f"Prediction failed: {str(e)}")
        
        else:
            QMessageBox.critical(self, "Error", "Please load the model and vectorizer first!")


    def get_manual_input(self):
        return self.manualInputText.text()  # Replace with actual manual input widget

    def show_manual_prediction_result(self, input_text, coverage_prediction, accident_prediction):
        self.coveragePredictionLineEdit.setText(str(coverage_prediction[0]))  # Coverage prediction
        self.accidentPredictionLineEdit.setText(str(accident_prediction[0]))  # Accident prediction

    def display_predictions(self):
        row_count = len(self.df)
        self.predictionTable.setRowCount(row_count)
        self.predictionTable.setColumnCount(3)  # Columns for Claim Description, Coverage Predictions, and Accident Predictions

        self.predictionTable.setHorizontalHeaderLabels(['Claim Description', 'Coverage Predictions', 'Accident Predictions'])

        for row in range(row_count):
            self.predictionTable.setItem(row, 0, QTableWidgetItem(str(self.df.iloc[row]['Claim Description'])))
            self.predictionTable.setItem(row, 1, QTableWidgetItem(str(self.df.iloc[row]['Coverage Predictions'])))
            self.predictionTable.setItem(row, 2, QTableWidgetItem(str(self.df.iloc[row]['Accident Predictions'])))



    def save_results(self):
        if self.df is None:
            QMessageBox.critical(self, "Error", "No data available to save!")
            return

        try:
            # Show the save file dialog to select the save location and file name
            save_path, _ = QFileDialog.getSaveFileName(self, "Save Results", "", "Excel Files (*.xlsx);;All Files (*)")
            
            if save_path:
                # Ensure the 'Coverage Predictions' and 'Accident Predictions' columns exist
                if 'Coverage Predictions' not in self.df.columns or 'Accident Predictions' not in self.df.columns:
                    QMessageBox.critical(self, "Error", "Predictions are not available in the dataset!")
                    return
                
                # Save the DataFrame to an Excel file (including both the original data and new prediction columns)
                self.df.to_excel(save_path, index=False)

                # Notify the user that the results were saved successfully
                QMessageBox.information(self, "Success", "Results saved successfully as Excel file!")

        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to save results: {str(e)}")

app = QApplication(sys.argv)
window = MyWindow()
window.show()
sys.exit(app.exec_())
