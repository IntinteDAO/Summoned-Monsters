        private bool ImFeelingLucky()
        {
            return Program.Rand.Next(10) >= 5 && DefaultDontChainMyself();
        }
