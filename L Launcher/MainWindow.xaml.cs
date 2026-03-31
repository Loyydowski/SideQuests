using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Installers;
using CmlLib.Core.ProcessBuilder;
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace KitLauncher
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            ramSlider.ValueChanged += (s, e) =>
            {
                if (ramLabel != null)
                    ramLabel.Text = $"{(int)ramSlider.Value} GB";
            };
        }

        private void TabNews_Click(object sender, RoutedEventArgs e)
            => SwitchTab("news");

        private void TabHome_Click(object sender, RoutedEventArgs e)
            => SwitchTab("home");

        private void TabMods_Click(object sender, RoutedEventArgs e)
            => SwitchTab("mods");

        private void SwitchTab(string tab)
        {
            panelNews.Visibility = Visibility.Collapsed;
            panelHome.Visibility = Visibility.Collapsed;
            panelMods.Visibility = Visibility.Collapsed;

            SetTabInactive(tabNews);
            SetTabInactive(tabHome);
            SetTabInactive(tabMods);

            switch (tab)
            {
                case "news":
                    panelNews.Visibility = Visibility.Visible;
                    SetTabActive(tabNews);
                    break;
                case "home":
                    panelHome.Visibility = Visibility.Visible;
                    SetTabActive(tabHome);
                    break;
                case "mods":
                    panelMods.Visibility = Visibility.Visible;
                    SetTabActive(tabMods);
                    break;
            }
        }

        private void SetTabActive(Button btn)
        {
            btn.Background = new SolidColorBrush(Color.FromRgb(58, 58, 58));
            btn.Foreground = Brushes.White;
            btn.BorderBrush = Brushes.Orange;
        }

        private void SetTabInactive(Button btn)
        {
            btn.Background = new SolidColorBrush(Color.FromRgb(45, 45, 45));
            btn.Foreground = Brushes.Gray;
            btn.BorderBrush = Brushes.Transparent;
        }
        private void UpdateProgress(string status, double progress)
        {
            Dispatcher.Invoke(() =>
            {
                statusText.Text = status;
                progressBar.Value = progress;
                progressText.Text = $"{(int)progress}%";
            });
        }
        private void SetLoadingState(bool isLoading)
        {
            Dispatcher.Invoke(() =>
            {
                loadingPanel.Visibility = isLoading ? Visibility.Visible : Visibility.Collapsed;
                play.Visibility = isLoading ? Visibility.Collapsed : Visibility.Visible;
            });
        }

        private async void play_Click(object sender, RoutedEventArgs e)
        {
            string nick = nickBox.Text;
            int ramGB = (int)ramSlider.Value;
            string[] versions = { "1.20.4", "1.19.2", "1.21.1" };
            string version = versions[versionCombo.SelectedIndex];

            play.IsEnabled = false;
            SetLoadingState(true);
            UpdateProgress("Inicjalizacja...", 0);
            try
            {
                UpdateProgress("Przygotowywanie ścieżek...", 5);
                var path = new MinecraftPath();

                UpdateProgress("Inicjalizacja launchera...", 10);
                var launcher = new MinecraftLauncher(path);
                launcher.FileProgressChanged += (s, args) =>
                {
                    double percent = 10 + (args.ProgressedTasks / (double)args.TotalTasks * 70);
                    string fileName = args.Name ?? "pliki";
                    UpdateProgress($"Pobieranie: {fileName}", percent);
                };

                launcher.ByteProgressChanged += (s, args) =>
                {
                    if (args.TotalBytes > 0)
                    {
                        double mb = args.ProgressedBytes / 1024.0 / 1024.0;
                        double totalMb = args.TotalBytes / 1024.0 / 1024.0;
                        Dispatcher.Invoke(() =>
                        {
                            progressText.Text = $"{mb:F1} / {totalMb:F1} MB";
                        });
                    }
                };

                UpdateProgress("Sprawdzanie wersji...", 15);
                await launcher.InstallAsync(version);
                UpdateProgress("Tworzenie sesji...", 85);
                var session = MSession.CreateOfflineSession(nick);

                UpdateProgress("Konfiguracja uruchamiania...", 90);
                var launchOption = new MLaunchOption
                {
                    MaximumRamMb = ramGB * 1024,
                    Session = session,
                };

                UpdateProgress("Budowanie procesu...", 95);
                var process = await launcher.BuildProcessAsync(version, launchOption);
                UpdateProgress("Uruchamianie Minecraft...", 100);
                await System.Threading.Tasks.Task.Delay(500); 

                var gameProcess = process.Start();

                this.WindowState = WindowState.Minimized;
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Błąd podczas uruchamiania gry:\n{ex.Message}",
                    "Błąd KitLauncher",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
            finally
            {
                SetLoadingState(false);
                play.IsEnabled = true;
            }
        }
    }
}