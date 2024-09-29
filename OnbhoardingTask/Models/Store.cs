﻿using System;
using System.Collections.Generic;

namespace OnbhoardingTask.Models;

public partial class Store
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public string? Address { get; set; }

    public virtual ICollection<Sale> Sales { get; set; } = new List<Sale>();
}
