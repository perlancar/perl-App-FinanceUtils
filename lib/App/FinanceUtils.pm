package App::FinanceUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Perinci::Sub::Gen::FromFormulas qw(gen_funcs_from_formulas);

our %SPEC;

my $res = gen_funcs_from_formulas(
    prefix => 'calc_fv_',
    symbols => {
        fv => {
            caption => 'future value',
            schema => ['float*'],
        },
        pv => {
            caption => 'present value',
            schema => ['float*'],
        },
        r => {
            caption => 'return rate',
            summary => 'Return rate (e.g. 0.06 for 6%)',
            schema => ['float*', 'x.perl.coerce_rules'=>['str_percent']],
        },
        n => {
            caption => 'periods',
            summary => 'Number of periods',
            schema => ['float*'],
        },
    },
    formulas => [
        {
            formula => 'fv = pv*(1+r)**n',
            examples => [
                {
                    summary => 'Invest $100 at 6% annual return rate for 5 years',
                    args => {pv=>100, r=>0.06, n=>5},
                },
                {
                    summary => 'Ditto, using percentage notation on command-line',
                    src => '[[prog]] 100 6% 5',
                    src_plang => 'bash',
                },
            ],
        },
        {
            formula => 'pv = fv/(1+r)**n',
            examples => [
                {
                    summary => 'Want to get $100 after 5 years at 6% annual return rate, how much to invest?',
                    args => {fv=>100, r=>0.06, n=>5},
                },
            ],
        },
        {
            formula => 'r = (fv/pv)**(1/n) - 1',
            examples => [
                {
                    summary => 'Want to get $120 in 5 years using $100 investment, what is the required return rate?',
                    args => {fv=>120, pv=>100, n=>5},
                },
            ],
        },
        {
            formula => 'n = log(fv/pv) / log(1+r)',
            examples => [
                {
                    summary => 'Want to get $120 using $100 investment with annual 6% return rate, how many years must we wait?',
                    args => {fv=>120, pv=>100, r=>0.06},
                },
            ],
        },
    ],
);
$res->[0] == 200 or die "Can't generate calc_fv_* functions: $res->[0] - $res->[1]";

1;
# ABSTRACT: Financial CLI utilities

=head1 DESCRIPTION

This distribution contains some CLI's to do financial calculations:

# INSERT_EXECS_LIST

=cut
