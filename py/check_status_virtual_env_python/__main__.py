import os


class VirtualEnvironmentChecker:
    def check_virtual_environment(self):
        """
        Check if a Python virtual environment is currently active.

        This function checks if the 'VIRTUAL_ENV' environment variable is set. If it is, it indicates
        that a virtual environment is active.

        Returns:
            None
        """
        try:
            if 'VIRTUAL_ENV' in os.environ:
                print("Python virtual environment is currently active! 🤩")
            else:
                print("Python virtual environment is currently inactif! 😢")
        except Exception as e:
            print(f"Une erreur s'est produite : {e}")

if __name__ == "__main__":
    checker = VirtualEnvironmentChecker()
    checker.check_virtual_environment()
