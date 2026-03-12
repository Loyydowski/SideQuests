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

            // Slider RAM — aktualizacja etykiety
            ramSlider.ValueChanged += (s, e) =>
            {
                if (ramLabel != null)
                    ramLabel.Text = $"{(int)ramSlider.Value} GB";
            };
        }

        // ---------- Przełączanie zakładek ----------

        private void TabNews_Click(object sender, RoutedEventArgs e)
            => SwitchTab("news");

        private void TabHome_Click(object sender, RoutedEventArgs e)
            => SwitchTab("home");

        private void TabMods_Click(object sender, RoutedEventArgs e)
            => SwitchTab("mods");

        private void SwitchTab(string tab)
        {
            // Ukryj wszystkie panele
            panelNews.Visibility = Visibility.Collapsed;
            panelHome.Visibility = Visibility.Collapsed;
            panelMods.Visibility = Visibility.Collapsed;

            // Zresetuj styl wszystkich przycisków
            SetTabInactive(tabNews);
            SetTabInactive(tabHome);
            SetTabInactive(tabMods);

            // Pokaż wybrany panel i podświetl przycisk
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
            btn.Background = new SolidColorBrush(Color.FromRgb(58, 58, 58));   // jaśniejszy
            btn.Foreground = Brushes.White;
            btn.BorderBrush = Brushes.Orange;
        }

        private void SetTabInactive(Button btn)
        {
            btn.Background = new SolidColorBrush(Color.FromRgb(45, 45, 45));   // ciemniejszy
            btn.Foreground = Brushes.Gray;
            btn.BorderBrush = Brushes.Transparent;
        }

        // ---------- Przycisk Graj ----------

        private void play_Click(object sender, RoutedEventArgs e)
        {
            string nick = nickBox.Text;
            string version = (versionCombo.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "";
            int ram = (int)ramSlider.Value;

            MessageBox.Show(
                $"Uruchamiam grę...\n\nNick: {nick}\nWersja: {version}\nRAM: {ram} GB",
                "KitLauncher",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}