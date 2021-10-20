        public override int OnSelectOption(IList<int> options)
        {
            return Program.Rand.Next(options.Count);
        }
