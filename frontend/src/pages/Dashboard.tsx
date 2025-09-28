import { useEffect, useState } from 'react';
import axios from 'axios';
import type { AxiosResponse } from 'axios';

interface SummaryResponse {
  totalIncome: number;
  totalExpense: number;
  net: number;
  burnRate: number;
}

export default function Dashboard() {
  const [summary, setSummary] = useState<SummaryResponse | null>(null);

  useEffect(() => {
    const fetchSummary = async () => {
      try {
        const token = localStorage.getItem('accessToken');
        const res: AxiosResponse<SummaryResponse> = await axios.get(
          'http://localhost:8080/api/analytics/summary?month=2025-09',
          {
            headers: { Authorization: `Bearer ${token}` },
          }
        );
        setSummary(res.data);
      } catch (err) {
        console.error('Failed to load summary', err);
      }
    };

    fetchSummary();
  }, []);

  return (
    <div>
      <h1>Dashboard</h1>
      {summary ? (
        <ul>
          <li>Total Income: {summary.totalIncome}</li>
          <li>Total Expense: {summary.totalExpense}</li>
          <li>Net: {summary.net}</li>
          <li>Burn Rate: {summary.burnRate}</li>
        </ul>
      ) : (
        <p>Loading summary...</p>
      )}
    </div>
  );
}
