            AddExecutor(ExecutorType.Activate, ImFeelingLucky);
            AddExecutor(ExecutorType.SpSummon, ImFeelingLucky);

            AddExecutor(ExecutorType.SpSummon, ImFeelingUnlucky);
            AddExecutor(ExecutorType.Activate, ImFeelingUnlucky);

            AddExecutor(ExecutorType.SummonOrSet, ImFeelingLazy);
            AddExecutor(ExecutorType.SpellSet, DefaultSpellSet);
            AddExecutor(ExecutorType.Repos, DefaultMonsterRepos);