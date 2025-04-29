import os
import subprocess
from datetime import datetime, timedelta

# const
PATIENT_IDS = ["2025000001", "2025000002"]
PULSOXIMETRIE_VALUES = [0, 1, 2, 3]
SCHLAFLABOR_VALUES = [0, 1, 2, 3, 4, 5, 6, 7]
AHI_VALUES = [3, 8]
MIN_TEST_DURATION_HOURS = 6
DATE_FORMAT = "%d.%m.%Y"
TIME_FORMAT = "%H:%M"

# generate
def generate_test_files():
    base_date = datetime.now()
    start_time = base_date.replace(hour=0, minute=0)
    end_time = start_time + timedelta(hours=MIN_TEST_DURATION_HOURS)

    for patient_id in PATIENT_IDS:
        for ahi in AHI_VALUES:
            for pulsoximetrie in PULSOXIMETRIE_VALUES:
                for schlaflabor in SCHLAFLABOR_VALUES:
                    # Skip invalid combinations
                    if pulsoximetrie == 0 and schlaflabor != 0:
                        continue

                    # filename
                    filename = f"test_{patient_id}_ahi{ahi}_pulsox{pulsoximetrie}_schlaflab{schlaflabor}"

                    # Command to execute
                    command = [
                        "java", "-jar", "messdatengenerator.jar",
                        filename,
                        base_date.strftime(DATE_FORMAT),
                        start_time.strftime(TIME_FORMAT),
                        end_time.strftime(TIME_FORMAT),
                        patient_id,
                        str(ahi),
                        str(pulsoximetrie),
                        str(schlaflabor)
                    ]

                    # Execute the command
                    try:
                        subprocess.run(command, check=True)
                        print(f"Generated: {filename}.csv")
                    except subprocess.CalledProcessError as e:
                        print(f"Error generating {filename}: {e}")

if __name__ == "__main__":
    generate_test_files()